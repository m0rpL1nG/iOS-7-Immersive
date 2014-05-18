//
//  PYLTask.h
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const taskTitleKey;
extern NSString * const taskDescriptionKey;
extern NSString * const taskDateKey;
extern NSString * const taskCompletionKey;

@interface PYLTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

- (id)initWithData:(NSDictionary *)data;
- (NSDictionary *)propertyList;

@end
