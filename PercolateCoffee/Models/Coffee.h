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

- (BOOL)isValidCoffee;
+(NSString *)dateDiff:(NSDate *)origDate;

@end
