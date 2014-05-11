//
//  PYLSignInViewController.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLSignInViewController.h"
#import "PYLViewController.h"

@interface PYLSignInViewController ()

@end

@implementation PYLSignInViewController

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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PYLCreateAccountViewController class]]) {
        PYLCreateAccountViewController *createAccountViewController = segue.destinationViewController;
        createAccountViewController.delegate = self;
    }

    if ([segue.destinationViewController isKindOfClass:[PYLViewController class]]) {
        PYLAccount *account = [[PYLAccount alloc] initWithUsername:self.usernameTextField.text andPassword:self.passwordTextField.text];
        PYLViewController *viewController = segue.destinationViewController;
        viewController.account = account;
    }
}

# pragma mark - Actions

- (IBAction)createAccountButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toCreateAccountViewController" sender:sender];
}

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    NSString *userLogin = [[NSUserDefaults standardUserDefaults] objectForKey:AccountUsernameKey];
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:AccountPasswordKey];

    if ([userLogin isEqualToString:self.usernameTextField.text] && [userPassword isEqualToString:self.passwordTextField.text]) {
        [self performSegueWithIdentifier:@"toViewController" sender:sender];

        return;
    }

    [[[UIAlertView alloc] initWithTitle:@"Login failed" message:@"The username and/or password are invalid. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

#pragma mark - PYLCreateAccountViewControllerDelegate methods

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didCreateAccount
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
