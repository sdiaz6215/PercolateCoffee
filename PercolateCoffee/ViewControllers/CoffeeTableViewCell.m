//
//  CoffeeTableViewCell.m
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CoffeeDataManager.h"

@implementation CoffeeTableViewCell

@synthesize nameLabel, descriptionLabel, coffeeImageView, coffeeModel;

-(void)updateConstraints
{
    [super updateConstraints];
    [self.contentView layoutIfNeeded];
    
    //descriptionLabel.preferredMaxLayoutWidth = 200;
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    // Name Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:15.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:15.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:15.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nameLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:15.0]];
    
//    // Description Label
//    descriptionLabel.preferredMaxLayoutWidth = 200;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:nameLabel
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1.0
//                                                                  constant:8.0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
//                                                                 attribute:NSLayoutAttributeLeading
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeLeading
//                                                                multiplier:1.0
//                                                                  constant:15.0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
//                                                                 attribute:NSLayoutAttributeTrailing
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeTrailing
//                                                                multiplier:1.0
//                                                                  constant:15.0]];
//
//    // Image View
//    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:coffeeImageView
//                                                        attribute:NSLayoutAttributeTop
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:descriptionLabel
//                                                        attribute:NSLayoutAttributeBottom
//                                                       multiplier:1.0
//                                                         constant:5],
//                           [NSLayoutConstraint constraintWithItem:coffeeImageView
//                                                        attribute:NSLayoutAttributeLeft
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:self
//                                                        attribute:NSLayoutAttributeLeft
//                                                       multiplier:1.0
//                                                         constant:15],
//                           [NSLayoutConstraint constraintWithItem:coffeeImageView
//                                                        attribute:NSLayoutAttributeWidth
//                                                        relatedBy:NSLayoutRelationLessThanOrEqual
//                                                           toItem:nil
//                                                        attribute:NSLayoutAttributeNotAnAttribute
//                                                       multiplier:1.0
//                                                         constant:300],
//                           [NSLayoutConstraint constraintWithItem:coffeeImageView
//                                                        attribute:NSLayoutAttributeHeight
//                                                        relatedBy:NSLayoutRelationLessThanOrEqual
//                                                           toItem:nil
//                                                        attribute:NSLayoutAttributeNotAnAttribute
//                                                       multiplier:1.0
//                                                         constant:300]
//                           ]
//     ];
}

- (void)setCoffeeModel:(Coffee *)_coffeeModel
{
    coffeeModel = _coffeeModel;
    
    [RACObserve(self, coffeeModel.name) subscribeNext:^(NSString *newName){
        [nameLabel setText:newName];
    }];
    
//    [RACObserve(self, coffeeModel.coffeeDescription) subscribeNext:^(NSString *newDescription){
//        [descriptionLabel setText:newDescription];
//    }];
//    
//    if(coffeeModel.imageData)
//    {
//        [coffeeImageView setHidden:NO];
//        [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
//    }
//    else
//    {
//        [coffeeImageView setHidden:YES];
//        [[[CoffeeDataManager sharedManager] downloadImageData:coffeeModel.imageUrl] subscribeNext:^(NSData *imageData)
//         {
//             coffeeModel.imageData = imageData;
//             [coffeeImageView setHidden:NO];
//             [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
//         }];
//    }
}

@end
