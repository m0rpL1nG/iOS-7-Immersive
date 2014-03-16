//
//  PYLUserData.m
//  User Data Challenge
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLUserData.h"

@implementation PYLUserData

+ (NSArray *)users
{
    NSDictionary *user1 = @{USER_USERNAME: @"User 1", USER_EMAIL: @"user1@example.org", USER_PASSWORD: @"U53R1", USER_AGE: @18, USER_PROFILE_PICTURE: [UIImage imageNamed:@"person1.jpeg"]};
    NSDictionary *user2 = @{USER_USERNAME: @"User 2", USER_EMAIL: @"user2@example.org", USER_PASSWORD: @"U53R2", USER_AGE: @19, USER_PROFILE_PICTURE: [UIImage imageNamed:@"person2.jpeg"]};
    NSDictionary *user3 = @{USER_USERNAME: @"User 3", USER_EMAIL: @"user3@example.org", USER_PASSWORD: @"U53R3", USER_AGE: @20, USER_PROFILE_PICTURE: [UIImage imageNamed:@"person3.jpg"]};
    NSDictionary *user4 = @{USER_USERNAME: @"User 4", USER_EMAIL: @"user4@example.org", USER_PASSWORD: @"U53R4", USER_AGE: @21, USER_PROFILE_PICTURE: [UIImage imageNamed:@"person4.jpeg"]};

    return @[user1, user2, user3, user4];
}

@end
