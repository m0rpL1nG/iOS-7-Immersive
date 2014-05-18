//
//  PYLAddTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required
- (void)didCancel;
- (void)didAddTask:(PYLTask *)task;

@end

@interface PYLAddTaskViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)SaveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
