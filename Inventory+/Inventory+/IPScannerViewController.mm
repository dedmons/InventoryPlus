//
//  IPScannerViewController.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPScannerViewController.h"
#import "QRCodeReader.h"
#import "ZXingWidgetController.h"
#import "IPLocationViewController.h"
#import "IPInventoryViewController.h"
#import "IPItemInventoryManagerViewController.h"
#import "IPUser.h"

@interface IPScannerViewController () <ZXingDelegate>

@property (nonatomic, assign) NSInteger once;
@end

@implementation IPScannerViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.once = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.once == 0) {
        ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
        widController.readers = readers;
        
        //[self presentModalViewController:widController animated:YES];
        [self.navigationController presentModalViewController:widController animated:NO];
        self.once = 1;
    }
}

- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    NSLog(@"%@",result);
    [self dismissModalViewControllerAnimated:NO];
    
    PFObject *obj = [PFObject objectWithoutDataWithClassName:@"IPInventoryItem" objectId:result];
    [obj fetchIfNeeded];
    IPInventoryItem *item = [[IPInventoryItem alloc] initFromParseObject: obj];

    
    if ([IPUser currentUser].role == IPManagerUser) {
        NSLog(@"manager");
        IPItemInventoryManagerViewController *inventoryViewController = [[IPItemInventoryManagerViewController alloc] initWithItem:item];
        inventoryViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Inventory" image:[UIImage imageNamed:@"Archive.png"] tag:2];
      
      IPLocationViewController *locationViewController = [[IPLocationViewController alloc] init];
      locationViewController.item = item;
      locationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Location" image:[UIImage imageNamed:@"Target.png"] tag:1];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.title = item.name;
        tabBarController.viewControllers = @[ locationViewController, inventoryViewController ];
        
        UINavigationController *nvc = self.navigationController;
        [nvc popViewControllerAnimated:NO];
        [nvc pushViewController:tabBarController animated:YES];
        
    }else{
        NSLog(@"worker");
        IPInventoryViewController *inventoryViewController = [[IPInventoryViewController alloc]initWithNibName:@"IPInventoryViewController" bundle:nil];
        
        inventoryViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Inventory" image:[UIImage imageNamed:@"Archive.png"] tag:2];
        inventoryViewController.item = item;
        
        
        IPLocationViewController *locationViewController = [[IPLocationViewController alloc]initWithNibName:@"IPLocationViewController" bundle:nil];
        
        locationViewController.item = item;
        
        locationViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Location" image:[UIImage imageNamed:@"Target.png"] tag:1];
        
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        
        tabBarController.viewControllers = [NSArray arrayWithObjects:locationViewController,inventoryViewController, nil];
        
        UINavigationController *nvc = self.navigationController;
        [nvc popViewControllerAnimated:NO];
        [nvc pushViewController:tabBarController animated:YES];
        [locationViewController setLabels];
        
        [inventoryViewController setValuesToLabel];
    }

}


- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
