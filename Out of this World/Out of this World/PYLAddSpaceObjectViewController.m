//
//  PYLAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 10/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLAddSpaceObjectViewController.h"

@interface PYLAddSpaceObjectViewController ()

@end

@implementation PYLAddSpaceObjectViewController

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

    // Could be done using interface builder
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

- (IBAction)addButtonPressed:(UIButton *)sender
{
    [self.delegate addSpaceObject:[self returnNewSpaceObject]];
}

- (PYLSpaceObject *)returnNewSpaceObject
{
    PYLSpaceObject *spaceObject = [[PYLSpaceObject alloc] init];
    spaceObject.name = self.nameTextField.text;
    spaceObject.nickname = self.nicknameTextField.text;
    spaceObject.diameter = [self.diameterTextField.text floatValue];
    spaceObject.temperature = [self.temperatureTextField.text floatValue];
    spaceObject.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    spaceObject.interestingFact = self.interestingFactTextField.text;
    spaceObject.image = [UIImage imageNamed:@"EinsteinRing.jpg"];

    return spaceObject;
}

@end
