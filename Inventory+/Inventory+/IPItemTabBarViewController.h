//
//  IPItemTabBarViewController.h
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPLocationViewController.h"
#import "IPInventoryViewController.h"


@interface IPItemTabBarViewController : UIViewController<UITabBarDelegate>

@property(strong)IPInventoryViewController  *inventoryViewController;
@property(strong)IPLocationViewController *locationViewController;
@property(strong)UITabBarController *tabBarController;


@end
