//
//  IPItemInventoryManagerViewController.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPItemInventoryManagerViewController.h"
#import "IPItemAttributesViewController.h"
#import "IPOrderViewController.h"

@interface IPItemInventoryManagerViewController ()

@property (strong, nonatomic) IPInventoryItem *item;

@end

@implementation IPItemInventoryManagerViewController

- (id)initWithItem:(IPInventoryItem *)item
{
  self = [super initWithNibName:nil bundle:nil];
  if ( self ) {
    self.item = item;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  self.nameLabel.text = self.item.name;
  self.descriptionLabel.text = self.item.description;
    self.barView.maxAmmount = self.item.capacity;
    self.barView.desiredAmmount = self.item.desiredInventory;
    self.barView.alertAmmount = self.item.alertInventory;
    self.maxLabel.text = [NSString stringWithFormat:@"%d",self.item.capacity];
    self.normLabel.text = [NSString stringWithFormat:@"%d",self.item.desiredInventory];
    self.critLabel.text = [NSString stringWithFormat:@"%d",self.item.alertInventory];
    self.curLabel.text = [NSString stringWithFormat:@"%d",self.item.currentInventory];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.barView.currentAmmount = self.item.currentInventory;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)editButtonPressed:(UIButton *)sender
{
  [self.navigationController pushViewController:[[IPItemAttributesViewController alloc] initWithItem:self.item] animated:YES];
}

- (void)orderButtonPressed:(UIButton *)sender
{
  [self.navigationController pushViewController:[[IPOrderViewController alloc] initWithItem:self.item] animated:YES];
}

@end
