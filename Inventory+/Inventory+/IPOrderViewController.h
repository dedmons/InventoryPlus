//
//  IPOrderViewController.h
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPInventoryItem.h"

@interface IPOrderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *capacityLabel;

- (id)initWithItem:(IPInventoryItem *)item;

- (IBAction)stepperDidStep:(UIStepper *)sender;
- (IBAction)submitButtonPressed:(UIButton *)sender;

@end
