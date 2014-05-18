//
//  PYLDetailTaskViewController.m
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLDetailTaskViewController.h"

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
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.task.date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PYLEditTaskViewControllerDelegate methods

- (void)didUpdateTask
{
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.task.date];

    [self.navigationController popViewControllerAnimated:YES];

    if (self.delegate) {
        [self.delegate updateTask];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PYLEditTaskViewController class]]) {
        PYLEditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        editTaskViewController.delegate = self;
    }
}

#pragma mark - Actions

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:nil];
}

@end
