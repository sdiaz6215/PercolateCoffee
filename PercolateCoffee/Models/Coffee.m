//
//  Coffee.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "Coffee.h"

@implementation Coffee

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
    
    return self;
}

@end
