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
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *coffeeImageView;
@property (nonatomic, retain) IBOutlet UILabel *relativeUpdateTimeLabel;

- (void)setCoffeeModel:(Coffee *)_coffeeModel;

@end
