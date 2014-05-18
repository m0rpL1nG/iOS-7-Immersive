//
//  PYLDetailTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"
#import "PYLEditTaskViewController.h"

@protocol DetailTaskViewControllerDelegate <NSObject>

@required
- (void)didEditTask:(PYLTask *)task;

@end

@interface PYLDetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (strong, nonatomic) PYLTask *task;
@property (nonatomic) NSInteger index;
@property (weak, nonatomic) id <DetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
