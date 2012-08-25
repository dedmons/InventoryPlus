//
//  IPViewController.h
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPStartViewController : UIViewController <PFLogInViewControllerDelegate>

- (IBAction)logout:(id)sender;
- (IBAction)scann;

@end
