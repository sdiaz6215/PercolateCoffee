//
//  CoffeeTableViewController.m
//  Coffee
//
//  Created by Steven Diaz on 5/7/15.
//  Copyright (c) 2015 Steven Diaz. All rights reserved.
//

#import "CoffeeTableViewController.h"
#import "Constants.h"
#import "CoffeeDetailViewController.h"
#import "CoffeeDataManager.h"
#import "CoffeeTableViewCell.h"

@interface CoffeeTableViewController ()

@end

@implementation CoffeeTableViewController
{
    CoffeeTableViewCell *sizingCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleNavigationBar];
    [self setupPullToRefresh];
    [self pullCoffeeData];
    
    [self.tableView registerClass:[CoffeeTableViewCell class] forCellReuseIdentifier:kCellIdentifierCoffeeTable];
}

- (void)styleNavigationBar
{
    // Nav Bar Coffee Drop Image
    UIImageView *coffeeDropImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [coffeeDropImageView setContentMode:UIViewContentModeScaleAspectFit];
    [coffeeDropImageView setImage:[UIImage imageNamed:@"CoffeeDrop"]];
    self.navigationItem.titleView = coffeeDropImageView;
    
    //  Removes the "Back" label from the back button on any VCs pushed to nav stack
    self.title = @"";
}

- (void)setupPullToRefresh
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:kStylingOrange];
    [self.refreshControl addTarget:self action:@selector(pullCoffeeData) forControlEvents:UIControlEventValueChanged];
}

- (void)pullCoffeeData
{
    [[CoffeeDataManager sharedManager] getAllCoffeeSuccess:^(){
        [self refreshUI];
    }failure:^(NSError *error){
        [[[UIAlertView alloc] initWithTitle:@"Oops" message:[NSString stringWithFormat:@"Our coffee machine seems to be down. Check your connection and try again.\n\nAdditional Details: %@", error.localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
}

- (void)refreshUI
{
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CoffeeDataManager sharedManager] allCoffee] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This method is taking a dummy cell that we only allocate once and using it to calculate the row height ahead of time
    // by having it layout it's subviews and adding constraints. We need this because we don't have any of this information when
    // the data source asks for row height. iOS 8 has a super easy method :)
    
    if(!sizingCell)
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifierCoffeeTable];
    
    Coffee *currentCoffeeModel = [[[CoffeeDataManager sharedManager] allCoffee] objectAtIndex:indexPath.row];
    [sizingCell setCoffeeModel:currentCoffeeModel];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1; // +1 is for line separator
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoffeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierCoffeeTable forIndexPath:indexPath];
    
    Coffee *currentCoffeeModel = [[[CoffeeDataManager sharedManager] allCoffee] objectAtIndex:indexPath.row];
    [cell setCoffeeModel:currentCoffeeModel];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Coffee *currentCoffeeModel = [[[CoffeeDataManager sharedManager] allCoffee] objectAtIndex:indexPath.row];
    CoffeeDetailViewController *coffeeDetailVC = [[UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil]
                                                  instantiateViewControllerWithIdentifier:kControllerIdentifierCoffeeDetail];
    [coffeeDetailVC setCoffeeModel:currentCoffeeModel];
    [self.navigationController pushViewController:coffeeDetailVC animated:YES];
}
@end
