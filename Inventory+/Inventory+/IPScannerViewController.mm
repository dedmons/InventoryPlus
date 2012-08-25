//
//  IPScannerViewController.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPScannerViewController.h"
#import "ZXingWidgetController.h"
#import "IPLocationViewController.h"
#import "IPInventoryViewController.h"
#import "IPItemInventoryManagerViewController.h"
#import "IPUser.h"

@interface IPScannerViewController () <ZXingDelegate>

@end

@implementation IPScannerViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    ZXingWidgetController *wc = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    [self presentViewController:wc animated:YES completion:nil];
}

- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    NSLog(@"%@",result);
    [self dismissModalViewControllerAnimated:NO];
    
    PFObject *obj = [PFObject objectWithoutDataWithClassName:@"IPInventoryItem" objectId:result];
    [obj fetchIfNeeded];
    
    if ([IPUser currentUser].role == IPManagerUser) {
        NSLog(@"manager");
        IPItemInventoryManagerViewController *inventoryViewController = [[IPItemInventoryManagerViewController alloc] initWithItem:((IPInventoryItem *) obj)];
        inventoryViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Inventory" image:nil tag:1];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.title = ((IPInventoryItem *) obj).name;
        tabBarController.viewControllers = @[ inventoryViewController ];
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:tabBarController animated:YES];
        
    }else{
        NSLog(@"worker");
        IPInventoryViewController *inventoryViewController = [[IPInventoryViewController alloc]initWithNibName:@"IPInventoryViewController" bundle:nil];
        
        inventoryViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Inventory" image:nil tag:1];
        inventoryViewController.item = ((IPInventoryItem *) obj);
        
        
        IPLocationViewController *locationViewController = [[IPLocationViewController alloc]initWithNibName:@"IPLocationViewController" bundle:nil];
        
        locationViewController.item = ((IPInventoryItem *) obj);
        
        locationViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Location" image:nil tag:2];
        
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        
        tabBarController.viewControllers = [NSArray arrayWithObjects:locationViewController,inventoryViewController, nil];
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:tabBarController animated:YES];
        [locationViewController setLabels];
        
        [inventoryViewController setValuesToLabel];
    }

}


- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
