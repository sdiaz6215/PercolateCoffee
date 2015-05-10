//
//  CoffeeTableViewCell.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeTableViewCell.h"

@implementation CoffeeTableViewCell

@synthesize nameLabel, descriptionLabel, coffeeImageView, coffeeModel;

- (void)setupAutolayoutConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:30]];
}

- (void)setCoffeeModel:(Coffee *)_coffeeModel
{
    [self setupAutolayoutConstraints];
    
    coffeeModel = _coffeeModel;
    nameLabel.text = coffeeModel.name;
    descriptionLabel.text = coffeeModel.coffeeDescription;
    [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
}

@end
