//
//  PYLViewController.m
//  Age of Laika
//
//  Created by Pierre-Yves LEBECQ on 08/03/2014.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertToDogYearsButtonPressed:(UIButton *)sender
{
    self.resultLabel.text = [NSString stringWithFormat:@"%i", [self.humanYearsTextField.text intValue] * 7];
}

- (IBAction)convertToRealDogYearsButtonPressed:(UIButton *)sender
{
    int humanYears = [self.humanYearsTextField.text intValue];
    int dogYears;

    if (humanYears > 2) {
        dogYears = (10.5 * 2) + ((humanYears - 2) * 4);
    } else {
        dogYears = (10.5 * humanYears);
    }

    self.realYearsLabel.text = [NSString stringWithFormat:@"%i", dogYears];
}
@end
