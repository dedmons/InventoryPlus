//
//  IPInventoryItemLocation.h
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <Parse/Parse.h>

@interface IPInventoryItemLocation : PFObject

@property (assign, nonatomic) NSUInteger aisle;
@property (assign, nonatomic) NSUInteger section;

@end
