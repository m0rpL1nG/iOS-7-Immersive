//
//  PYLSignInViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAccount.h"
#import "PYLCreateAccountViewController.h"

@interface PYLSignInViewController : UIViewController <PYLCreateAccountViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)createAccountButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)loginButtonPressed:(UIButton *)sender;

@end
