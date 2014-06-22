//
//  PYLCoreDataHelper.m
//  Thousand Words
//
//  Created by Pierre-Yves LEBECQ on 21/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLCoreDataHelper.h"

@implementation PYLCoreDataHelper

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];

    if ([delegate respondsToSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }

    return context;
}

@end
