//
//  IPInventoryViewController.h
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPInventoryItem.h"

@interface IPInventoryViewController : UIViewController


@property(weak ) IBOutlet UILabel *name;
@property(weak) IBOutlet UILabel *description;
@property(weak) IBOutlet UILabel *count;
@property(weak) IBOutlet UIStepper *stepper;

@property(weak)IBOutlet UIButton *updateButton;

@property(strong) IPInventoryItem *item;

-(IBAction)doChangeCount:(id)sender;
-(IBAction)doUpdate:(id)sender;

- (NSInteger)getHeightForText:(NSString *)string OfFont:(UIFont *)font forWidth:(CGFloat)width;
-(void)setValuesToLabel;

@end
