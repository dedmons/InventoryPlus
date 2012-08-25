//
//  IPUser.h
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IPUnknownUser = 0,
    IPManagerUser = 1,
    IPWorkerUser = 2
} IPUserRole;

@interface IPUser : NSObject

@property (nonatomic, readonly) IPUserRole role;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, readonly) NSString *userName;

+(IPUser *)currentUser;

@end
