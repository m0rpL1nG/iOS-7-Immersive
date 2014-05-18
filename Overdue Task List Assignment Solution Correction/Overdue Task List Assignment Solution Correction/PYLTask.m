//
//  PYLTask.m
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLTask.h"

@implementation PYLTask

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];

    if (self) {
        self.title = data[TASK_TITLE];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }

    return self;
}

- (id)init
{
    self = [self initWithData:nil];

    return self;
}

@end
