//
//  IPInventoryItem.h
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPInventoryItem : NSObject

@property (copy, readonly, nonatomic) NSString *identifier;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *description;

@property (assign, nonatomic) NSUInteger currentInventory;
@property (assign, nonatomic) NSUInteger capacity;
@property (assign, nonatomic) NSUInteger desiredInventory;
@property (assign, nonatomic) NSUInteger alertInventory;

// Category
@property (copy, nonatomic) NSString *category;

// Location
@property (assign, nonatomic) NSInteger aisle;
@property (assign, nonatomic) NSInteger section;

- (void)loadWithIdentifier:(NSString *)identifier
                     block:(void(^)(BOOL succeeded, NSError *error))block;

- (void)saveInBackgroundWithBlock:(void(^)(BOOL succeeded, NSError *error))block;

@end
