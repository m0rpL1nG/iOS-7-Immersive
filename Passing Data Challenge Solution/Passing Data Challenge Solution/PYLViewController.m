//
//  PYLViewController.m
//  Passing Data Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 13/04/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLDetailViewController.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Could also be done in interface builder.
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]] && [segue.destinationViewController isKindOfClass:[PYLDetailViewController class]]) {
        PYLDetailViewController *nextViewController = segue.destinationViewController;
        nextViewController.textToDisplay = self.textField.text;
        nextViewController.delegate = self;
    }
}

#pragma mark - PYLDetailViewControllerDelegate methods

- (void)didUpdateText:(NSString *)text
{
    self.textField.text = text;
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];

    return YES;
}

@end
