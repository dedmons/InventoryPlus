//
//  IPItemInventoryManagerViewController.h
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPInventoryItem.h"

@interface IPItemInventoryManagerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *inventoryView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;

- (id)initWithItem:(IPInventoryItem *)item;

@end
