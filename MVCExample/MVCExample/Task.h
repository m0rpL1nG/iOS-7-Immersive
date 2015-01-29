//
//  Task.h
//  MVCExample
//
//  Created by Pierre-Yves LEBECQ on 29/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *title;
@property (assign) BOOL isCompleted;

@end
