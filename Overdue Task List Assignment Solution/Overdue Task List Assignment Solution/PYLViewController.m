//
//  PYLViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLTask.h"

static NSString * const tasksArrayKey = @"tasks";

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIBarButtonItem class]] && [segue.destinationViewController isKindOfClass:[PYLAddTaskViewController class]]) {
        PYLAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }

    if ([sender isKindOfClass:[UITableViewCell class]] && [segue.destinationViewController isKindOfClass:[PYLDetailTaskViewController class]]) {
        PYLDetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        PYLTask *task = [self.tasks objectAtIndex:indexPath.row];
        detailTaskViewController.task = task;
        detailTaskViewController.index = indexPath.row;
        detailTaskViewController.delegate = self;
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    PYLTask *task = [self.tasks objectAtIndex:indexPath.row];

    cell.textLabel.text = task.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [formatter stringFromDate:task.date];

    // Set background color.
    if (task.completion) {
        cell.backgroundColor = [UIColor colorWithRed:0.7 green:0.96 blue:0.53 alpha:1];
    } else if ([self isTaskOverdue:task]) {
        cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.58 blue:0.58 alpha:1];
    }

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PYLTask *task = [self.tasks objectAtIndex:indexPath.row];

    task.completion = YES;

    [self.tableView reloadData];
    [self persistTasks];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];

        [self.tableView reloadData];
        [self persistTasks];
    }
}

#pragma mark - AddTaskViewControllerDelegate methods

/**
 * Not used because the cancel button is provided by the navigation controller.
 * It would be used with a modal segue because the back button would not be provided for free.
 */
- (void)didCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didAddTask:(PYLTask *)task
{
    [self.tasks addObject:task];
    [self.tableView reloadData];
    [self persistTasks];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DetailTaskViewControllerDelegate methods

- (void)didEditTask:(PYLTask *)task
{
    [self.tableView reloadData];
    [self persistTasks];
}

#pragma mark - Helper methods

- (void)persistTasks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSMutableArray *tasksToPersist = [[NSMutableArray alloc] init];
    for (PYLTask *task in self.tasks) {
        [tasksToPersist addObject:[task propertyList]];
    }
    [userDefaults setObject:tasksToPersist forKey:tasksArrayKey];
    [userDefaults synchronize];
}

- (BOOL)isTaskOverdue:(PYLTask *)task
{
    if ([[NSDate date] compare:task.date] == NSOrderedDescending) {
        return YES;
    }

    return NO;
}

#pragma mark - Overriden getters and setters

- (NSMutableArray *)tasks
{
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
        NSArray *tasks = [[NSUserDefaults standardUserDefaults] arrayForKey:tasksArrayKey];
        for (NSDictionary *task in tasks) {
            PYLTask *taskObject = [[PYLTask alloc] initWithData:task];
            [_tasks addObject:taskObject];
        }
    }

    return _tasks;
}

@end
