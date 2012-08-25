//
//  IPInventoryItem.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPInventoryItem.h"

@implementation IPInventoryItem

// Create a new inventory item
- (id)init
{
  self = [PFObject objectWithClassName:@"IPInventoryItem"];
  if ( self ) {
    
  }
  return self;
}

// Load an existing inventory item from Parse
- (id)initWithIdentifier:(NSString *)identifier
{
  self = [PFObject objectWithoutDataWithClassName:@"IPInventoryItem" objectId:identifier];
  if ( self ) {
    
  }
  return self;
}

@end
