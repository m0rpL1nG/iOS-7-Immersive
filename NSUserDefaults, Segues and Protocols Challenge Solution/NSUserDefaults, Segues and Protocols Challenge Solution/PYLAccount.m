//
//  PYLAccount.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLAccount.h"

NSString * const AccountUsernameKey = @"username";
NSString * const AccountPasswordKey = @"password";

@implementation PYLAccount

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
    }

    return self;
}

@end
