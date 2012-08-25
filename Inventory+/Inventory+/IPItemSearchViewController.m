//
//  IPItemSearchViewController.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPItemSearchViewController.h"
#import "IPInventoryItem.h"
#import "IPUser.h"
#import "IPItemInventoryManagerViewController.h"

@interface IPItemSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *results;

@end

@implementation IPItemSearchViewController

- (void)awakeFromNib
{
  self.title = @"Search";
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
}

- (void)editButtonPressed:(UIBarButtonItem *)sender
{
  self.tableView.editing = ! self.tableView.editing;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ( self.results )
    return self.results.count;
  else
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
  if ( ! cell ) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
  }
  
  cell.textLabel.text = ((IPInventoryItem *) [self.results objectAtIndex:indexPath.row]).name;
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if ( [IPUser currentUser].role == IPManagerUser ) {
    
    IPItemInventoryManagerViewController *inventoryViewController = [[IPItemInventoryManagerViewController alloc] initWithItem:[self.results objectAtIndex:indexPath.row]];
    inventoryViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Inventory" image:nil tag:1];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.title = ((IPInventoryItem *) [self.results objectAtIndex:indexPath.row]).name;
    tabBarController.viewControllers = @[ inventoryViewController ];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
  }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return ([IPUser currentUser].role == IPManagerUser);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  PF_MBProgressHUD *hud = [PF_MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.labelText = @"Deleting...";
  [((IPInventoryItem *) [self.results objectAtIndex:indexPath.row]) deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [PF_MBProgressHUD hideHUDForView:self.view animated:YES];
    if ( succeeded ) {
      NSMutableArray *newResults = [self.results mutableCopy];
      [newResults removeObjectAtIndex:indexPath.row];
      self.results = newResults;
      [self.tableView reloadData];
    }
    else {
      [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
  }];
  
}

#pragma mark - Search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  PFQuery *categoryQuery = [[PFQuery alloc] initWithClassName:@"IPInventoryItem"];
  [categoryQuery whereKey:@"category" matchesRegex:searchBar.text modifiers:@"i"];
  
  PFQuery *nameQuery = [[PFQuery alloc] initWithClassName:@"IPInventoryItem"];
  [nameQuery whereKey:@"name" matchesRegex:searchBar.text modifiers:@"i"];
  
  PFQuery *query = [PFQuery orQueryWithSubqueries:@[ categoryQuery, nameQuery ]];
  
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"found objects");
    NSLog(@"%@", objects);
    
    NSMutableArray *items = [NSMutableArray array];
    for ( PFObject *parseObject in objects ) {
      [items addObject:[[IPInventoryItem alloc] initFromParseObject:parseObject]];
    }
    
    self.results = items;
    
    [self.tableView reloadData];
  }];
}

@end
