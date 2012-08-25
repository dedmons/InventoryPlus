//
//  IPLocationViewController.h
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPInventoryItem.h"

@interface IPLocationViewController : UIViewController

@property(weak)IBOutlet UILabel *nameLabel;
@property(weak)IBOutlet UILabel *descriptionLabel;
@property(weak)IBOutlet UILabel *aisleLabel;
@property(weak)IBOutlet UILabel *sectionLabel;

@property(strong)IPInventoryItem *item;

-(void)setLabels;
- (NSInteger)getHeightForText:(NSString *)string OfFont:(UIFont *)font forWidth:(CGFloat)width;

@end
