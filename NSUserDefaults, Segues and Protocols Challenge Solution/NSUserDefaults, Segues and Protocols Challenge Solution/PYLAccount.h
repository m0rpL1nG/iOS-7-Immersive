//
//  PYLAccount.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AccountUsernameKey;
extern NSString * const AccountPasswordKey;

@interface PYLAccount : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
