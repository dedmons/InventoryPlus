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
#import "IPInventoryViewController.h"
#import "IPLocationViewController.h"


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
    if ([IPUser currentUser].role == IPManagerUser) {
        NSLog(@"manager");
        
              
    }else{
        NSLog(@"worker");
        IPInventoryViewController *inventoryViewController = [[IPInventoryViewController alloc]initWithNibName:@"IPInventoryViewController" bundle:nil];
        
        inventoryViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Inventory" image:nil tag:1];
        inventoryViewController.item = [self.results objectAtIndex:indexPath.row];
        
        
        IPLocationViewController *locationViewController = [[IPLocationViewController alloc]initWithNibName:@"IPLocationViewController" bundle:nil];
        
        locationViewController.item = [self.results objectAtIndex:indexPath.row];
        
        locationViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Location" image:nil tag:2];
        
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        
        tabBarController.viewControllers = [NSArray arrayWithObjects:locationViewController,inventoryViewController, nil];
        
        
        [self.navigationController pushViewController:tabBarController animated:YES];
        [locationViewController setLabels];

        [inventoryViewController setValuesToLabel];
    }

  
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
