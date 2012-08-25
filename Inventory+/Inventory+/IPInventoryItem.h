//
//  IPInventoryItem.h
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <Parse/Parse.h>
#import "IPInventoryItemLocation.h"
#import "IPInventoryCategory.h"

@interface IPInventoryItem : PFObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *description;

@property (assign, nonatomic) NSUInteger currentInventory;
@property (assign, nonatomic) NSUInteger capacity;
@property (assign, nonatomic) NSUInteger desiredInventory;
@property (assign, nonatomic) NSUInteger alertInventory;

@property (strong, nonatomic) IPInventoryCategory *category;

@property (strong, nonatomic) IPInventoryItemLocation *location;

- (id)initWithIdentifier:(NSString *)identifier;

@end
