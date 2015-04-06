//
//  Venue.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 06/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic id;
@dynamic name;
@dynamic favorite;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end
