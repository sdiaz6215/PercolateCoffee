//
//  CoffeeDetailViewController.m
//  Coffee
//
//  Created by Steven Diaz on 5/7/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeDetailViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CoffeeDetailViewController ()

@end

@implementation CoffeeDetailViewController

@synthesize nameLabel, descriptionLabel, coffeeImageView, coffeeModel, relativeUpdateTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self styleNavigationBar];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareButtonPressed:(id)sender
{
    
}

- (void)setCoffeeModel:(Coffee *)_coffeeModel
{
    coffeeModel = _coffeeModel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
