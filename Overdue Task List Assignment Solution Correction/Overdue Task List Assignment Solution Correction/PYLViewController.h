//
//  PYLViewController.h
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAddTaskViewController.h"
#import "PYLDetailTaskViewController.h"

@interface PYLViewController : UIViewController <PYLAddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, PYLDetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tasks;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
