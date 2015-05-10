//
//  Coffee.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "Coffee.h"

@implementation Coffee

@synthesize name, coffeeDescription, imageUrl, imageData;

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
    
    if(imageUrl)
    {
        NSURL *url = [NSURL URLWithString:imageUrl];
        if(url)
            [self downloadImageData];
    }
    return self;
}

- (void)downloadImageData
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   NSLog(@"Image data successfully downloaded for URL: %@", imageUrl);
                                   imageData = data;
                               }
                           }];
}

- (BOOL)isValidCoffee
{
    if([name isEqualToString:@""])
        return NO;

    return YES;
}

@end
