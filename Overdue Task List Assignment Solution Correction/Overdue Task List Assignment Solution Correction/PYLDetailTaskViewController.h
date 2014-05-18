//
//  PYLDetailTaskViewController.h
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"
#import "PYLEditTaskViewController.h"

@protocol PYLDetailTaskViewControllerDelegate <NSObject>

@required
- (void)updateTask;

@end

@interface PYLDetailTaskViewController : UIViewController <PYLEditTaskViewControllerDelegate>

@property (strong, nonatomic) PYLTask *task;
@property (weak, nonatomic) id <PYLDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
