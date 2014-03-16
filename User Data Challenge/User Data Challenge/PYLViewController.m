//
//  PYLViewController.m
//  User Data Challenge
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLUserData.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.users = [PYLUserData users];
    NSLog(@"%@", self.users);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
