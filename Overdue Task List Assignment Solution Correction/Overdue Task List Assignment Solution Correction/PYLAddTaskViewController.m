//
//  PYLAddTaskViewController.m
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLAddTaskViewController.h"

@interface PYLAddTaskViewController ()

@end

@implementation PYLAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField.delegate = self;
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];

    return YES;
}

#pragma mark - UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];

        return NO;
    }

    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helper methods

- (PYLTask *)returnNewTaskObject
{
    PYLTask *task = [[PYLTask alloc] init];

    task.title = self.textField.text;
    task.description = self.textView.text;
    task.date = self.datePicker.date;
    task.isCompleted = NO;

    return task;
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate didCancel];
    }
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate didAddTask:[self returnNewTaskObject]];
    }
}

@end
