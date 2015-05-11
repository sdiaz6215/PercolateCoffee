//
//  CoffeeDetailViewController.m
//  Coffee
//
//  Created by Steven Diaz on 5/7/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeDetailViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Constants.h"

@interface CoffeeDetailViewController ()

@end

@implementation CoffeeDetailViewController

@synthesize nameLabel, titleSeparator, descriptionLabel, coffeeImageView, coffeeModel, relativeUpdateTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self styleNavigationBar];
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(coffeeModel)
    {
        [RACObserve(self, coffeeModel.name) subscribeNext:^(NSString *newName){
            [nameLabel setText:newName];
        }];
        
        [RACObserve(self, coffeeModel.coffeeDescription) subscribeNext:^(NSString *newDescription){
            [descriptionLabel setText:newDescription];
        }];
        
        [RACObserve(self, coffeeModel.lastUpdatedDate) subscribeNext:^(NSDate *newDate){
            [relativeUpdateTimeLabel setText:[NSString stringWithFormat:@"Updated %@", [Coffee dateDiff:newDate]]];
        }];
        
        [RACObserve(self, coffeeModel.imageData) subscribeNext:^(NSData *newImageData){
            [coffeeImageView setImage:[UIImage imageWithData:newImageData]];
        }];
    }
}

-(void)initSubviews
{
    nameLabel = [[UILabel alloc] init];
    [nameLabel setFont:kStylingDetailViewNameFont];
    //nameLabel.backgroundColor = [UIColor greenColor];
    [nameLabel setTextColor:kStylingColorDarkGrey];
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nameLabel setPreferredMaxLayoutWidth:200.0];
    [self.view addSubview:nameLabel];
    
    titleSeparator = [[UIView alloc] init];
    [titleSeparator setBackgroundColor:kStylingColorLightGrey];
    [titleSeparator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:titleSeparator];
    
    descriptionLabel = [[UILabel alloc] init];
    [descriptionLabel setFont:kStylingDetailViewDescriptionFont];
    //descriptionLabel.backgroundColor = [UIColor blueColor];
    [descriptionLabel setTextColor:kStylingColorLightGrey];
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [descriptionLabel setNumberOfLines:0];
    //[descriptionLabel setPreferredMaxLayoutWidth:250];
    [self.view addSubview:descriptionLabel];
    
    coffeeImageView = [[UIImageView alloc] init];
    //coffeeImageView.backgroundColor = [UIColor redColor];
    [coffeeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [coffeeImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:coffeeImageView];
    
    relativeUpdateTimeLabel = [[UILabel alloc] init];
    [relativeUpdateTimeLabel setFont:kStylingDetailViewRelativeUpdateTimeFont];
    //relativeUpdateTimeLabel.backgroundColor = [UIColor yellowColor];
    [relativeUpdateTimeLabel setTextColor:kStylingColorLightGrey];
    [relativeUpdateTimeLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [relativeUpdateTimeLabel setNumberOfLines:1];
    //[relativeUpdateTimeLabel setPreferredMaxLayoutWidth:200];
    [self.view addSubview:relativeUpdateTimeLabel];
}

- (void)styleNavigationBar
{
    // Nav Bar Coffee Drop Image
    UIImageView *coffeeDropImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [coffeeDropImageView setContentMode:UIViewContentModeScaleAspectFit];
    [coffeeDropImageView setImage:[UIImage imageNamed:@"CoffeeDrop"]];
    self.navigationItem.titleView = coffeeDropImageView;
    
    // Nav Bar Share Button
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareButton"]
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonPressed:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    // Nav Bar Back Button
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"BackArrow"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"BackArrow"];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    // Name Label
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginTopPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginLeftPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginRightPadding]];
    
    // Title Separator
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleSeparator
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nameLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewMarginTopPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleSeparator
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewMarginLeftPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:titleSeparator
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewTitleSeparatorRightMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleSeparator
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewTitleSeparatorHeight]];
    
    
    // Description Label
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:titleSeparator
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginTopPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginLeftPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:descriptionLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:kStylingDetailViewMarginRightPadding]];
    
    if(coffeeModel.imageData != nil)
    {
        // Image View
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:descriptionLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewSubviewPadding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewMarginLeftPadding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewMarginRightPadding]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewEstimatedImageSize]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coffeeImageView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewEstimatedImageSize]];
        
        // Relative Time Label
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:relativeUpdateTimeLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:coffeeImageView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewSubviewPadding]];
    }
    else
        // Relative Time Label
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:relativeUpdateTimeLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:descriptionLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:kStylingDetailViewSubviewPadding]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:relativeUpdateTimeLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewMarginLeftPadding]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:relativeUpdateTimeLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:kStylingDetailViewMarginRightPadding]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareButtonPressed:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Not Implemented, just for show. :)" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)setCoffeeModel:(Coffee *)_coffeeModel
{
    coffeeModel = _coffeeModel;
}

@end
