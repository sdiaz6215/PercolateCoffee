//
//  Coffee.h
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Coffee : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *coffeeDescription;
@property (nonatomic, copy, readonly) NSString *imageUrl;
@property (nonatomic, copy) NSData *imageData;
@property (nonatomic, copy, readonly) NSDate *lastUpdatedDate;

/**
 Used for determining whether Coffee object is worthy enough to show in the table view.
 A number of items returned in the response JSON appear to be dummy objects
 */
- (BOOL)isValidCoffee;

/**
 Validation for the URL
 */
- (BOOL)isURLValid;

/**
 Helper method for concatenating a relativew "Last Updated" date string
 */
+(NSString *)dateDiff:(NSDate *)origDate;

@end
