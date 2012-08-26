//
//  IPOrderViewController.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPOrderViewController.h"

@interface IPOrderViewController ()

@property (strong, nonatomic) IPInventoryItem *item;

@end

@implementation IPOrderViewController

- (id)initWithItem:(IPInventoryItem *)item
{
  self = [super initWithNibName:nil bundle:nil];
  if ( self ) {
    self.item = item;
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.itemLabel.text = self.item.name;
  self.capacityLabel.text = [NSString stringWithFormat:@"Capacity: %d", self.item.capacity];
  self.currentLabel.text = [NSString stringWithFormat:@"Current inventory: %d", self.item.currentInventory];
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

- (IBAction)stepperDidStep:(UIStepper *)sender
{
  self.countField.text = [NSString stringWithFormat:@"%.0lf", sender.value];
}

- (IBAction)submitButtonPressed:(UIButton *)sender
{
  PFObject *object = [PFObject objectWithClassName:@"IPOrder"];
  [object setValue:self.item.identifier forKey:@"itemIdentifier"];
  [object setValue:[NSNumber numberWithInteger:self.countField.text.integerValue] forKey:@"orderCount"];
  
  PF_MBProgressHUD *hud = [PF_MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.labelText = @"Ordering...";
  [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    [PF_MBProgressHUD hideHUDForView:self.view animated:YES];
    if ( succeeded ) {
      [self.navigationController popViewControllerAnimated:YES];
    }
    else {
      [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
  }];
}

@end
