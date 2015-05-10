//
//  Coffee.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "Coffee.h"

@implementation Coffee

@synthesize name, coffeeDescription, imageUrl, imageData, lastUpdatedDate;

+(NSString *)dateDiff:(NSDate *)origDate {
    NSDate *todayDate = [NSDate date];
    double ti = [origDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"just now";
    } else 	if (ti < 60) {
        return @"less than a minute ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d minutes ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hours ago", diff];
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%d days ago", diff];
    } else {
        return @"never";
    }	
}

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"identifier": @"id",
             @"name": @"name",
             @"coffeeDescription": @"desc",
             @"imageUrl": @"image_url",
             };
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if(!self)
        return nil;
    
    lastUpdatedDate = [NSDate date];
    
    return self;
}

- (BOOL)isValidCoffee
{
    if([name isEqualToString:@""])
        return NO;

    return YES;
}

- (BOOL)isURLValid
{
    if(imageUrl && ![imageUrl isEqualToString:@""])
    {
        NSURL *url = [NSURL URLWithString:imageUrl];
        if(url)
            return YES;
    }
    
    return NO;
}

@end
