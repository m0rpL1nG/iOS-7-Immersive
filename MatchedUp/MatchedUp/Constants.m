//
//  Constants.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 15/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - User Class

NSString * const kUserTagLineKey                    = @"tagLine";

NSString * const kUserProfileKey                    = @"profile";
NSString * const kUserProfileNameKey                = @"name";
NSString * const kUserProfileFirstNameKey           = @"first_name";
NSString * const kUserProfileLocationKey            = @"location";
NSString * const kUserProfileGenderKey              = @"gender";
NSString * const kUserProfileBirthdayKey            = @"birthday";
NSString * const kUserProfileInterestedInKey        = @"interested_in";
NSString * const kUserProfilePictureURLKey          = @"pictureURL";
NSString * const kUserProfileRelationshipStatusKey  = @"relationshipStatus";
NSString * const kUserProfileAgeKey                 = @"age";

#pragma mark - Photo Class

NSString * const kPhotoClassKey     = @"Photo";
NSString * const kPhotoUserKey      = @"user";
NSString * const kPhotoPictureKey   = @"image";

#pragma mark - Activity Class

NSString * const kActivityClassKey = @"Activity";
NSString * const kActivityTypeKey = @"type";
NSString * const kActivityFromUserKey = @"fromUser";
NSString * const kActivityToUserKey = @"toUser";
NSString * const kActivityPhotoKey = @"photo";
NSString * const kActivityTypeLikeKey = @"like";
NSString * const kActivityTypeDislikeKey = @"dislike";

@end
