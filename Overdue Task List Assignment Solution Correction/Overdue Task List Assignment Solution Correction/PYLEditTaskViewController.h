//
//  PYLEditTaskViewController.h
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLTask.h"

@protocol PYLEditTaskViewControllerDelegate <NSObject>

@required
- (void)didUpdateTask;

@end

@interface PYLEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) PYLTask *task;
@property (weak, nonatomic) id <PYLEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
