//
//  PYLViewController.m
//  View Objects In Code
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 22)];
    self.label.text = @"This is a label";
    self.label.textColor = [UIColor blueColor];
    [self.view addSubview:self.label];

    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 280, 30)];
    self.textfield.placeholder = @"Please enter some text";
    self.textfield.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textfield];

    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(20, 160, 280, 30);
    [self.button setTitle:@"press me!" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(UIButton *)sender
{
    self.label.text = self.textfield.text;
}

@end
