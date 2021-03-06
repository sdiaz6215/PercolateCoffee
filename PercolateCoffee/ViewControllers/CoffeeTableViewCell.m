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
#import "Constants.h"

@implementation CoffeeTableViewCell
{
    NSMutableArray *constraintsWithImage;
    NSMutableArray *constraintsWithoutImage;
}

@synthesize nameLabel, descriptionLabel, coffeeImageView, coffeeModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.clipsToBounds = YES;
        
        constraintsWithImage = [NSMutableArray array];
        constraintsWithoutImage = [NSMutableArray array];
        [self initSubviews];
        [self applyConstraints];
    }
    
    return self;
}

-(void)initSubviews
{
    nameLabel = [[UILabel alloc] init];
    [nameLabel setTextColor:kStylingColorDarkGrey];
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nameLabel setPreferredMaxLayoutWidth:200.0];
    [self.contentView addSubview:nameLabel];
    
    descriptionLabel = [[UILabel alloc] init];
    [descriptionLabel setTextColor:kStylingColorLightGrey];
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [descriptionLabel setNumberOfLines:2];
    [descriptionLabel setPreferredMaxLayoutWidth:200];
    [self.contentView addSubview:descriptionLabel];
    
    coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kStylingCellEstimatedImageSize, kStylingCellEstimatedImageSize)];
    [coffeeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [coffeeImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:coffeeImageView];
}

-(void)layoutSubviews
{
    [nameLabel setFont:kStylingCellNameFont];
    [descriptionLabel setFont:kStylingCellDescriptionFont];
    
    [super layoutSubviews];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    if([coffeeModel isURLValid])
    {
        [self.contentView removeConstraints:constraintsWithoutImage];
        [self.contentView addConstraints:constraintsWithImage];
    }
    else
    {
        [self.contentView removeConstraints:constraintsWithImage];
        [self.contentView addConstraints:constraintsWithoutImage];
    }
}

- (void)applyConstraints
{
    // Name Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginTopPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginLeftPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginRightPadding]];
    
    // Description Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nameLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:kStylingCellSubviewPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginLeftPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginRightPadding]];
    
    // Constraints for when image is not present
    [constraintsWithoutImage addObject:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginBottomPadding]];
    
    // Constraints for when image is present
    [constraintsWithImage addObject:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:kStylingCellSubviewPadding]];
    [constraintsWithImage addObject:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginLeftPadding]];
    [constraintsWithImage addObject:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:kStylingCellMarginRightPadding]];
    [constraintsWithImage addObject:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:kStylingCellEstimatedImageSize]];
    [constraintsWithImage addObject:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:kStylingCellEstimatedImageSize]];
    
    NSLayoutConstraint *cellHeightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:coffeeImageView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:kStylingCellMarginBottomPadding];
    cellHeightConstraint.priority = 999;
    [constraintsWithImage addObject:cellHeightConstraint];
}

- (void)setCoffeeModel:(Coffee *)_coffeeModel
{
    coffeeModel = _coffeeModel;

    // Failed Reactive Cocoa Experiment, can't figure out memory issues with RACObserve. Tried weak self, as well
    
//    [RACObserve(self, coffeeModel.name) subscribeNext:^(NSString *newName){
//        [nameLabel setText:newName];
//    }];
//    
//    [RACObserve(self, coffeeModel.coffeeDescription) subscribeNext:^(NSString *newDescription){
//        [descriptionLabel setText:newDescription];
//    }];
//    
//    if([coffeeModel isURLValid] && coffeeModel.imageData)
//    {
//        [coffeeImageView setHidden:NO];
//        [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
//    }
//    else
//    {
//        [coffeeImageView setHidden:YES];
//        
//        if([coffeeModel isURLValid])
//        {
//            [[[CoffeeDataManager sharedManager] downloadImageData:coffeeModel.imageUrl] subscribeNext:^(NSData *imageData)
//             {
//                 coffeeModel.imageData = imageData;
//                 [coffeeImageView setHidden:NO];
//                 [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
//                 [self setNeedsUpdateConstraints];
//                 [self setNeedsLayout];
//             }];
    //        }
    //    }
    
    [nameLabel setText:coffeeModel.name];
    [descriptionLabel setText:coffeeModel.coffeeDescription];
    
    if([coffeeModel isURLValid] && coffeeModel.imageData)
    {
        [coffeeImageView setHidden:NO];
        [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
    }
    else
    {
        [coffeeImageView setHidden:YES];
        
        if([coffeeModel isURLValid])
        {
            [[[CoffeeDataManager sharedManager] downloadImageData:coffeeModel.imageUrl] subscribeNext:^(NSData *imageData)
             {
                 coffeeModel.imageData = imageData;
                 [coffeeImageView setHidden:NO];
                 [coffeeImageView setImage:[UIImage imageWithData:coffeeModel.imageData]];
                 [self setNeedsUpdateConstraints];
                 [self setNeedsLayout];
             }];
        }
    }
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

@end
