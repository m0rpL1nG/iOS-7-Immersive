//
//  TestUser.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "TestUser.h"
#import <Parse/Parse.h>
#import "Constants.h"

@implementation TestUser

+ (void)saveTestUserToParse
{
    PFUser *user = [PFUser user];
    user.username = @"user1";
    user.password = @"password1";

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{kUserProfileAgeKey: @28, kUserProfileBirthdayKey: @"02/15/1988", kUserProfileFirstNameKey: @"Julie", kUserProfileGenderKey: @"female", kUserProfileLocationKey: @"Berlin, Germany", kUserProfileNameKey: @"Julie Adams"};
            [user setObject:profile forKey:kUserProfileKey];

            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"ProfileImage1.jpg"];
                NSData *data = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *file = [PFFile fileWithData:data];
                [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kPhotoClassKey];
                        [photo setObject:user forKey:kPhotoUserKey];
                        [photo setObject:file forKey:kPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo saved successfully");
                        }];
                    }
                }];
            }];
        }
    }];
}

@end
