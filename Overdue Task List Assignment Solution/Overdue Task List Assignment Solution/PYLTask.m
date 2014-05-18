//
//  PYLTask.m
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLTask.h"

NSString * const taskTitleKey = @"title";
NSString * const taskDescriptionKey = @"description";
NSString * const taskDateKey = @"date";
NSString * const taskCompletionKey = @"completion";

@implementation PYLTask

- (id)init
{
    NSDictionary *data = @{taskTitleKey: @"New task", taskDescriptionKey: @"Task details", taskDateKey: [NSDate date], taskCompletionKey: @1};

    return [self initWithData:data];
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.title = data[taskTitleKey];
        self.description = data[taskDescriptionKey];
        self.date = data[taskDateKey];
        self.completion = [data[taskCompletionKey] boolValue];
    }

    return self;
}

- (NSDictionary *)propertyList
{
    NSDictionary *data = @{
                           taskTitleKey: self.title,
                           taskDescriptionKey: self.description,
                           taskDateKey: self.date,
                           taskCompletionKey: [NSNumber numberWithBool:self.completion]
                           };

    return data;
}

@end
