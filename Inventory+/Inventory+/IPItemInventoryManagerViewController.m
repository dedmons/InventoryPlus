//
//  IPItemInventoryManagerViewController.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPItemInventoryManagerViewController.h"

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

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.nameLabel.text = self.item.name;
  self.descriptionLabel.text = self.item.description;
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

@end
