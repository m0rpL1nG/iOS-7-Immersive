//
//  PYLViewController.m
//  Prep For Pirate Assignment
//
//  Created by Pierre-Yves LEBECQ on 09/03/2014.
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
    NSString *firstString = @"First string";
    NSString *secondString = @"Second string";

    NSMutableArray *myMutableArray = [[NSMutableArray alloc] init];
    [myMutableArray addObject:firstString];
    [myMutableArray addObject:secondString];

    NSArray *myArray = [[NSArray alloc] initWithObjects:firstString, myMutableArray, secondString, nil];
    //NSLog(@"%@", myArray);

    self.currentPoint = CGPointMake(3, 4);

    int x = 10;
    int y = 20;
    if (x == 10) {
        NSLog(@"x equals 10");
        if (y == 20) {
            NSLog(@"Both are true");
        }
    }

    [self.myButton setTitle:@"Button Pressed" forState:UIControlStateNormal];
    self.myButton.hidden = NO;

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You triggered the alert" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];

    self.awesomeClass = [[PYLAwesomeClass alloc] init];

    NSString *testString = @"has a value";
    if (testString != nil) {
        NSLog(@"The test string has a value");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
