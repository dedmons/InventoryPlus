//
//  IPInventoryItem.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPInventoryItem.h"
#import <Parse/Parse.h>

@interface IPInventoryItem()

@property (strong, nonatomic) PFObject *parseObject;

@end

@implementation IPInventoryItem

- (id)init
{
  self = [super init];
  if ( self ) {
    self.parseObject = [[PFObject alloc] initWithClassName:@"IPInventoryItem"];
  }
  return self;
}

- (id)initFromParseObject:(PFObject *)object
{
  self = [super init];
  if ( self ) {
    self.parseObject = object;
  }
  return self;
}

- (NSString *)identifier
{
  return self.parseObject.objectId;
}

// Load an existing inventory item from Parse
- (void)loadWithIdentifier:(NSString *)identifier block:(void (^)(BOOL, NSError *))block
{
  self.parseObject = [PFObject objectWithoutDataWithClassName:@"IPInventoryItem" objectId:identifier];
  
  [self.parseObject fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
    if ( error ) {
      block(NO, error);
    }
    else {
      block(YES, nil);
    }
  }];
}

- (void)saveInBackgroundWithBlock:(void (^)(BOOL, NSError *))block
{
  [self.parseObject saveInBackgroundWithBlock:block];
}

#pragma mark - Properties

- (NSString *)name
{
  return [self.parseObject objectForKey:@"name"];
}

- (void)setName:(NSString *)name
{
  [self.parseObject setObject:name forKey:@"name"];
}

- (NSString *)description
{
  return [self.parseObject objectForKey:@"description"];
}

- (void)setDescription:(NSString *)description
{
  [self.parseObject setObject:description forKey:@"description"];
}

- (NSInteger)capacity
{
  return [[self.parseObject objectForKey:@"capacity"] integerValue];
}

- (void)setCapacity:(NSInteger)capacity
{
  [self.parseObject setObject:[NSNumber numberWithInteger:capacity] forKey:@"capacity"];
}

- (NSInteger)desiredInventory
{
  return [[self.parseObject objectForKey:@"desiredInventory"] integerValue];
}

- (void)setDesiredInventory:(NSInteger)desiredInventory
{
  [self.parseObject setObject:[NSNumber numberWithInteger:desiredInventory] forKey:@"desiredInventory"];
}

- (NSInteger)alertInventory
{
  return [[self.parseObject objectForKey:@"alertInventory"] integerValue];
}

- (void)setAlertInventory:(NSInteger)alertInventory
{
  [self.parseObject setObject:[NSNumber numberWithInteger:alertInventory] forKey:@"alertInventory"];
}

- (NSInteger)currentInventory
{
  return [[self.parseObject objectForKey:@"currentInventory"] integerValue];
}

- (void)setCurrentInventory:(NSInteger)currentInventory
{
  [self.parseObject setObject:[NSNumber numberWithInteger:currentInventory] forKey:@"currentInventory"];
}

- (NSString *)category
{
  return [self.parseObject objectForKey:@"category"];
}

- (void)setCategory:(NSString *)category
{
  [self.parseObject setObject:category forKey:@"category"];
}

- (NSInteger)aisle
{
  return [[self.parseObject objectForKey:@"aisle"] integerValue];
}

- (void)setAisle:(NSInteger)aisle
{
  [self.parseObject setObject:[NSNumber numberWithInteger:aisle] forKey:@"aisle"];
}

- (NSInteger)section
{
  return [[self.parseObject objectForKey:@"section"] integerValue];
}

- (void)setSection:(NSInteger)section
{
  [self.parseObject setObject:[NSNumber numberWithInteger:section] forKey:@"section"];
}

@end
