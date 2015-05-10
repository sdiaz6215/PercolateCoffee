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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static CoffeeTableViewCell *sizingCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifierCoffeeTable];
//    });
//    
//    Coffee *currentCoffeeModel = [[[CoffeeDataManager sharedManager] allCoffee] objectAtIndex:indexPath.row];
//    [sizingCell setCoffeeModel:currentCoffeeModel];
//    
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height + 1.0f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CoffeeTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifierCoffeeTable];
    });
    
    Coffee *currentCoffeeModel = [[[CoffeeDataManager sharedManager] allCoffee] objectAtIndex:indexPath.row];
    [sizingCell setCoffeeModel:currentCoffeeModel];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
