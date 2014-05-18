//
//  PYLViewController.m
//  Overdue Task List Assignment Solution Correction
//
//  Created by Pierre-Yves LEBECQ on 18/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

#pragma mark - Overridden getters and setters

- (NSMutableArray *)tasks
{
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }

    return _tasks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY];
    for (NSDictionary *dictionary in tasksAsPropertyLists) {
        [self.tasks addObject:[self taskForDictionary:dictionary]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PYLAddTaskViewControllerDelegate methods

- (void)didAddTask:(PYLTask *)task
{
    [self.tasks addObject:task];

    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    if (!tasksAsPropertyLists) {
        tasksAsPropertyLists = [[NSMutableArray alloc] init];
    }

    [tasksAsPropertyLists addObject:[self taskAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    PYLTask *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.title;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;

    BOOL isOverdue = [self isDate:[NSDate date] greaterThanDate:task.date];

    if (task.isCompleted) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (isOverdue) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
    }

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PYLTask *task = self.tasks[indexPath.row];

    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];

        NSMutableArray *tasksData = [[NSMutableArray alloc] init];
        for (PYLTask *task in self.tasks) {
            [tasksData addObject:[self taskAsPropertyList:task]];
        }

        [[NSUserDefaults standardUserDefaults] setObject:tasksData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    PYLTask *task = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:task atIndex:destinationIndexPath.row];

    [self saveTasks];
}

#pragma mark - PYLDetailTaskViewControllerDelegate methods

- (void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PYLAddTaskViewController class]]) {
        PYLAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[PYLDetailTaskViewController class]]) {
        PYLDetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailTaskViewController.task = self.tasks[indexPath.row];
        detailTaskViewController.delegate = self;
    }
}

#pragma mark - Helper methods

- (NSDictionary *)taskAsPropertyList:(PYLTask *)task
{
    return @{TASK_TITLE: task.title, TASK_DESCRIPTION: task.description, TASK_DATE: task.date, TASK_COMPLETION: @(task.isCompleted)};
}

- (PYLTask *)taskForDictionary:(NSDictionary *)dictionary
{
    return [[PYLTask alloc] initWithData:dictionary];
}

- (BOOL)isDate:(NSDate *)date greaterThanDate:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];

    if (dateInterval > toDateInterval) {
        return YES;
    }

    return NO;
}

- (void)updateCompletionOfTask:(PYLTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    if (!tasksAsPropertyLists) {
        tasksAsPropertyLists = [[NSMutableArray alloc] init];
    }

    [tasksAsPropertyLists removeObjectAtIndex:indexPath.row];

    if (task.isCompleted) {
        task.isCompleted = NO;
    } else {
        task.isCompleted = YES;
    }

    [tasksAsPropertyLists insertObject:[self taskAsPropertyList:task] atIndex:indexPath.row];

    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.tableView reloadData];
}

- (void)saveTasks
{
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    for (PYLTask *task in self.tasks) {
        [tasksAsPropertyLists addObject:[self taskAsPropertyList:task]];
    }

    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Actions

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

@end
