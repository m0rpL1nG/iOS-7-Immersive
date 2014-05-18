//
//  PYLAddTaskViewController.h
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"

@protocol PYLAddTaskViewControllerDelegate <NSObject>

@required
- (void)didCancel;
- (void)didAddTask:(PYLTask *)task;

@end

@interface PYLAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <PYLAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;

@end
