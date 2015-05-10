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
                
                if([newCoffee isValidCoffee])
                    [coffeeArray addObject:newCoffee];
            }
            allCoffee = @[coffeeArray[0]];
            [self archiveData];
            success();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            // If we fail due to either not truly knowing the reachability status fast enough or endpoint issues,
            // lets see if we have any archived data as a fallback and send success. Ideally the user of this manager
            // shouldn't have to worry about states and cached/live data management.
            
            if([self unarchiveData])
                success();
            else
                failure(error);
        }];
    }
    else
    {
        NSLog(@"Network unreachable, falling back to archived coffee.");
        
        // If network is not reachable AND we have not unarchived yet, try to unarchive as a fallback
        if([self unarchiveData])
            success();
        else
            failure(nil);
    }
}

- (RACSignal*)downloadImageData:(NSString*)imageUrl
{
    return [RACSignal startLazilyWithScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground] block:^(id subscriber){
        if(imageUrl)
        {
            NSURL *url = [NSURL URLWithString:imageUrl];
            if(url)
            {
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if ( !error )
                                           {
                                               NSLog(@"Image data successfully downloaded for URL: %@", imageUrl);
                                               [subscriber sendNext:data];
                                               [subscriber sendCompleted];
                                               [self archiveData];
                                           }
                                           else
                                               [subscriber sendError:error];
                                       }];
            }
            else
                [subscriber sendError:nil];
        }
        else
            [subscriber sendError:nil];
    }];
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

- (BOOL)unarchiveData
{
    NSString *filePath = [self archivalDocumentsPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        allCoffee = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if(!allCoffee)
            NSLog(@"Error Unarchiving Coffee!");
        else
            NSLog(@"Coffee Unarchiving Successful!");
    }
    else
        NSLog(@"No Archived Coffee Found.");
    
    if(!allCoffee)
        return NO;
    else
        return YES;
}

@end
