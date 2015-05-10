//
//  CoffeeDataManager.h
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 `CoffeeDataManager` handles API requests to retrieve coffee and archiving/unarchiving
*/
@interface CoffeeDataManager : NSObject

@property (nonatomic, retain) NSArray *allCoffee;

/**
 Returns a static instance of 'CoffeeDataManager'
 */
+(CoffeeDataManager*)sharedManager;

/**
 Retrieves all coffee and archives results
 Endpoint: 'https://coffeeapi.percolate.com/api/coffee/'
 */
- (void)getAllCoffeeSuccess:(void (^)())success
                   failure:(void (^)(NSError *error))failure;

/**
 Creates an RACSignal and downloads image data for supplied url
 */
- (RACSignal*)downloadImageData:(NSString*)imageUrl;

/**
 Saves current coffee data using NSKeyedArchiver
 */
- (void)archiveData;

@end
