//
//  PYLUserData.h
//  User Data Challenge
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_USERNAME @"username"
#define USER_EMAIL @"email"
#define USER_PASSWORD @"password"
#define USER_AGE @"age"
#define USER_PROFILE_PICTURE @"profilePicture"

@interface PYLUserData : NSObject

+ (NSArray *)users;

@end
