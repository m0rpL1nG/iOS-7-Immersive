//
//  Venue.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"


@implementation Venue

@dynamic name;
@dynamic id;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end
