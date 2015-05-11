//
//  CoffeeTableViewCell.h
//  Coffee
//
//  Created by Steven Diaz on 5/9/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coffee.h"

@interface CoffeeTableViewCell : UITableViewCell

@property (nonatomic, retain, readonly) Coffee *coffeeModel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIImageView *coffeeImageView;

/**
 Sets the model used to populate the cell
 */
- (void)setCoffeeModel:(Coffee *)_coffeeModel;

@end
