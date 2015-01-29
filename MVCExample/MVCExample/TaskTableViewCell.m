//
//  TaskTableViewCell.m
//  MVCExample
//
//  Created by Pierre-Yves LEBECQ on 29/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "TaskTableViewCell.h"

@interface TaskTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *taskTitle;

@end

@implementation TaskTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTask:(Task *)task
{
    _task = task;

    [self configureView];
}

- (void)configureView
{
    self.taskTitle.text = self.task.title;

    if (self.task.isCompleted) {
        self.taskTitle.textColor = [UIColor greenColor];
    } else {
        self.taskTitle.textColor = [UIColor redColor];
    }
}

@end
