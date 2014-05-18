//
//  PYLViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAddTaskViewController.h"
#import "PYLDetailTaskViewController.h"

@interface PYLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddTaskViewControllerDelegate, DetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tasks;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
