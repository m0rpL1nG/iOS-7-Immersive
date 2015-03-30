//
//  Venue.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Record.h"

@class Contact;

@interface Venue : Record

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSManagedObject *categories;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) NSManagedObject *location;
@property (nonatomic, retain) NSManagedObject *menu;

@end
