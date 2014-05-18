//
//  PYLEditTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLEditTaskViewController.h"

@interface PYLEditTaskViewController ()

@end

@implementation PYLEditTaskViewController

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
    self.titleTextField.text = self.task.title;
    self.descriptionTextView.text = self.task.description;
    self.datePicker.date = self.task.date;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Actions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender
{
    self.task.title = self.titleTextField.text;
    self.task.description = self.descriptionTextView.text;
    self.task.date = self.datePicker.date;

    if (self.delegate) {
        [self.delegate didEditTask:self.task];
    }
}

@end
