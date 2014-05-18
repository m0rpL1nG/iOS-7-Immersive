//
//  PYLEditTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required
- (void)didEditTask:(PYLTask *)task;

@end

@interface PYLEditTaskViewController : UIViewController

@property (strong, nonatomic) PYLTask *task;
@property (nonatomic) NSInteger index;
@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
