//
//  FoursquareSessionManager.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FoursquareSessionManager : AFHTTPSessionManager

+ (instancetype) sharedClient;

@end
