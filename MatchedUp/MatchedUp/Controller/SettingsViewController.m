//
//  SettingsViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UISwitch *showMenSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *showWomenSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *onlySinglesSwitch;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Initialize sliders
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kSettingsAgeMaxKey];
    self.showMenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsMenEnabledKey];
    self.showWomenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsWomenEnabledKey];
    self.onlySinglesSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsSingleEnabledKey];
    // Add handler for event change
    [self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.showMenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.showWomenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.onlySinglesSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    self.ageLabel.text = [NSString stringWithFormat:@"%i", (int) self.ageSlider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions

- (IBAction)logoutButtonPressed:(UIButton *)sender
{
}

- (IBAction)editProfileButtonPressed:(UIButton *)sender
{
}

#pragma mark - Helper methods

- (void)valueChanged:(id)sender
{
    if (sender == self.ageSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:self.ageSlider.value forKey:kSettingsAgeMaxKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%i", (int) self.ageSlider.value];
    } else if (sender == self.showMenSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.showMenSwitch.isOn forKey:kSettingsMenEnabledKey];
    } else if (sender == self.showWomenSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.showWomenSwitch.isOn forKey:kSettingsWomenEnabledKey];
    } else if (sender == self.onlySinglesSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.onlySinglesSwitch.isOn forKey:kSettingsSingleEnabledKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
