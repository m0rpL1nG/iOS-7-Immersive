//
//  ViewController.m
//  MVCExample
//
//  Created by Pierre-Yves LEBECQ on 29/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
#import "TaskTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tasks;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    Task *task1 = [[Task alloc] init];
    task1.title = @"Eat breakfast";
    task1.isCompleted = NO;

    Task *task2 = [[Task alloc] init];
    task2.title = @"Go running";
    task2.isCompleted = YES;

    Task *task3 = [[Task alloc] init];
    task3.title = @"Do homework";
    task3.isCompleted = NO;

    self.tasks = [@[task1, task2, task3] mutableCopy];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TaskCell";

    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.task = self.tasks[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = self.tasks[indexPath.row];
    task.isCompleted = !task.isCompleted;

    [self.tableView reloadData];
}

@end
