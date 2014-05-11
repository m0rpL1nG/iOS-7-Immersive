//
//  PYLCreateAccountViewController.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLCreateAccountViewController.h"
#import "PYLAccount.h"

@interface PYLCreateAccountViewController ()

@end

@implementation PYLCreateAccountViewController

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
    if (self.delegate) {
        [self.delegate didCancel];
    }
}

- (IBAction)createAccountButtonPressed:(UIButton *)sender
{
    if (self.usernameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Username is missing" message:@"Please enter a username." delegate:nil cancelButtonTitle:@"Understood" otherButtonTitles:nil] show];

        return;
    }

    if (self.passwordTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Password is missing" message:@"Please enter a password." delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil] show];

        return;
    }

    if (![self.confirmPasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        [[[UIAlertView alloc] initWithTitle:@"Password confirmation error" message:@"The provided confirmation of password does not match the password." delegate:nil cancelButtonTitle:@"I will get new fingers" otherButtonTitles:nil] show];

        return;
    }

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.usernameTextField.text forKey:AccountUsernameKey];
    [userDefaults setObject:self.passwordTextField.text forKey:AccountPasswordKey];
    [userDefaults synchronize];

    if (self.delegate) {
        [self.delegate didCreateAccount];
    }
}

@end
