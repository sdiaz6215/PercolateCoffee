//
//  CoffeeDetailViewController.h
//  Coffee
//
//  Created by Steven Diaz on 5/7/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coffee.h"

@interface CoffeeDetailViewController : UIViewController

@property (nonatomic, retain, readonly) Coffee *coffeeModel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIView *titleSeparator;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIImageView *coffeeImageView;
@property (nonatomic, retain) UILabel *relativeUpdateTimeLabel;

/**
 Sets the model used to populate the VC
 */
- (void)setCoffeeModel:(Coffee *)_coffeeModel;

@end
