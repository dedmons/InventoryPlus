//
//  IPUser.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPUser.h"

@implementation IPUser

-(IPUserRole)role{
    NSString *role = [self.user objectForKey:@"role"];
    if ([role isEqualToString:@"Manager"]){
        return IPManagerUser;
    } else if ([role isEqualToString:@"Worker"]){
        return IPWorkerUser;
    }
    return IPUnknownUser;
}

-(NSString *)userName {
    return self.user.username;
}

+(IPUser *)currentUser{
    static dispatch_once_t ipUser = 0;
    __strong static id _object = nil;
    dispatch_once(&ipUser, ^{
        _object = [[IPUser alloc] init];
    });
    
    if ([PFUser currentUser]) {
        ((IPUser*)_object).user = [PFUser currentUser];
        return _object;
    } else
        return nil;
}

@end
