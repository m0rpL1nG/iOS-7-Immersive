//
//  FoursquareSessionManager.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "FoursquareSessionManager.h"

static NSString * const FoursquareBaseUrlString = @"https://api.foursquare.com/v2/";

@implementation FoursquareSessionManager

+ (instancetype)sharedClient
{
    static FoursquareSessionManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[FoursquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:FoursquareBaseUrlString]];
    });

    return sharedClient;
}

@end
