//
//  CoffeeDataManager.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeDataManager.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "Coffee.h"

@implementation CoffeeDataManager
{
    AFNetworkReachabilityStatus reachabilityStatus;
}

@synthesize allCoffee;

+(CoffeeDataManager*)sharedManager
{
    static CoffeeDataManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CoffeeDataManager alloc] init];
    });
    
    return _sharedManager;
}

-(instancetype)init
{
    self = [super init];
    [self startMonitoringReachability];
    return self;
}

- (NSString *)archivalDocumentsPath
{
    return [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:kArchivalPathComponent];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (void)startMonitoringReachability
{
    // -- Start monitoring network reachability (globally available) -- //
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    reachabilityStatus = AFNetworkReachabilityStatusUnknown;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        reachabilityStatus = status;
        
        NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
        
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                // -- Reachable -- //
//                NSLog(@"Reachable");
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            default:
//                // -- Not reachable -- //
//                NSLog(@"Not Reachable");
//                break;
//        }
    }];
}

- (BOOL)isNetworkReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void)getAllCoffeeSuccess:(void (^)())success
                   failure:(void (^)(NSError *error))failure
{
    // If network is reachable OR we haven't determined network status yet, let's give it a shot
    if([self isNetworkReachable] || reachabilityStatus == AFNetworkReachabilityStatusUnknown)
    {
        NSLog(@"Network Reachable, retrieving all coffee...");
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:kCoffeeAPIKey forHTTPHeaderField:@"Authorization"];
        [manager GET:kCoffeeAPIGetAll parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSMutableArray *coffeeArray = [NSMutableArray array];
            
            for(NSDictionary *dict in responseObject)
            {
                NSError *error;
                Coffee *newCoffee = [MTLJSONAdapter modelOfClass:[Coffee class] fromJSONDictionary:dict error:&error];
                [coffeeArray addObject:newCoffee];
            }
            allCoffee = coffeeArray;
            [self archiveData];
            success();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            failure(error);
        }];
    }
    else
    {
        NSLog(@"Network unreachable, falling back to archived coffee.");
        
        // If network is not reachable AND we have not unarchived yet, unarchive
        if(!allCoffee)
            [self unarchiveData];
        
        success();
    }
}

- (void)archiveData
{
    NSString *filePath = [self archivalDocumentsPath];
    BOOL success = [NSKeyedArchiver archiveRootObject:allCoffee toFile:filePath];
    
    if(success)
        NSLog(@"Archiving Coffee Successful!");
    else
        NSLog(@"Archiving Coffee Failed! We spilled it. =(");
}

- (void)unarchiveData
{
    NSString *filePath = [self archivalDocumentsPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        allCoffee = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    else
        NSLog(@"No Archived Coffee Found.");
    
    if(!allCoffee)
        NSLog(@"Error Unarchiving Coffee!");
    else
        NSLog(@"Coffee Unarchiving Successful!");
}

@end
