//
//  TaskTableViewCell.h
//  MVCExample
//
//  Created by Pierre-Yves LEBECQ on 29/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskTableViewCell : UITableViewCell

@property (strong, nonatomic) Task *task;

@end
