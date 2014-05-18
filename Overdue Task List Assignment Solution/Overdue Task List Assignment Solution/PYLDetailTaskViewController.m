//
//  PYLDetailTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLDetailTaskViewController.h"
#import "PYLEditTaskViewController.h"

@interface PYLDetailTaskViewController ()

@end

@implementation PYLDetailTaskViewController

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
    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EditTaskViewControllerDelegate methods

- (void)didEditTask:(PYLTask *)task
{
    [self updateView];

    [self.navigationController popViewControllerAnimated:YES];

    if (self.delegate) {
        [self.delegate didEditTask:task];
    }
}

#pragma mark - Helper methods

- (void)updateView
{
    self.titleLabel.text = self.task.title;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:self.task.date];
    self.descriptionLabel.text = self.task.description;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIBarButtonItem class]] && [segue.destinationViewController isKindOfClass:[PYLEditTaskViewController class]]) {
        PYLEditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        editTaskViewController.index = self.index;
        editTaskViewController.delegate = self;
    }
}

@end
