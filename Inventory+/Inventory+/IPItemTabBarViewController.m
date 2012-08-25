//
//  IPItemTabBarViewController.m
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPItemTabBarViewController.h"


@interface IPItemTabBarViewController ()

@end

@implementation IPItemTabBarViewController
@synthesize inventoryViewController;
@synthesize locationViewController;
@synthesize tabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            
//        self.viewControllers =  [NSArray arrayWithObjects:self.locationViewController, self.inventoryViewController, nil];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      
}
- (void)loadView {
    
    
//    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//	self.view = contentView;
    
  //       
//    UITabBarController *tempTabBarController = [[UITabBarController alloc] init];
//	tempTabBarController.view.frame = CGRectMake(0, 0, 320, 460);
//    
    
    //self.tabBarController = tempTabBarController;
    
    
//    self.tabBarController.viewControllers =  [NSArray arrayWithObjects:self.locationViewController, self.inventoryViewController, nil];
//      

   // self.view = self.tabBarController.view;
//    self.viewControllers = [NSArray arrayWithObjects:self.locationViewController, self.inventoryViewController, nil];
    

}

-(void)showInventory{
    if (!self.inventoryViewController) {
        // Custom initialization
        self.inventoryViewController = [[IPInventoryViewController alloc]initWithNibName:@"IPInventoryViewController" bundle:nil];
             
        
        
        self.inventoryViewController.title = @"Inventory";
        
        [self.view addSubview:self.inventoryViewController.view];

    }
    self.inventoryViewController.view.hidden = NO;
    self.locationViewController.view.hidden = YES;

}

-(void)showLocation{
    if (!self.locationViewController) {
        
        self.locationViewController = [[IPLocationViewController alloc] initWithNibName:@"IPLocationViewController" bundle:nil];
        self.locationViewController.title = @"Location";
        
        [self.view addSubview:self.locationViewController.view];
        
        
    }
    self.locationViewController.view.hidden = NO;
    self.inventoryViewController.view.hidden = YES;

    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"tab bar item changed. %@", item.title);
    if ([item.title isEqualToString:@"Feed"] ) {
          }
    else if([item.title isEqualToString:@"Inventory"] ){
        
        [self showInventory];
        
    }
    else if([item.title isEqualToString:@"Location"] ){
        [self showLocation];
             
    }    
    
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
