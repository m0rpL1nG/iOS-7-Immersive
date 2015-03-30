//
//  FSCategory.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Record.h"

@class Venue;

@interface FSCategory : Record

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
