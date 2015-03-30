//
//  Contact.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Record.h"

@interface Contact : Record

@property (nonatomic, retain) NSString * formattedPhone;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSManagedObject *venue;

@end
