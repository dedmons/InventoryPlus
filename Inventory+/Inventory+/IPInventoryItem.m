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
      // do stuff
      
      block(YES, nil);
    }
  }];
}

- (void)saveInBackgroundWithBlock:(void (^)(BOOL, NSError *))block
{
  if ( ! self.parseObject ) {
    self.parseObject = [[PFObject alloc] initWithClassName:@"IPInventoryItem"];
  }
  [self.parseObject saveInBackgroundWithBlock:block];
}

@end
