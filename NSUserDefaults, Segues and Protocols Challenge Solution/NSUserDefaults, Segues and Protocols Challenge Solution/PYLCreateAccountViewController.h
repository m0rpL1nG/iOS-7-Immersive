//
//  PYLCreateAccountViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PYLCreateAccountViewControllerDelegate <NSObject>

@required
- (void)didCancel;
- (void)didCreateAccount;

@end

@interface PYLCreateAccountViewController : UIViewController

@property id <PYLCreateAccountViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)createAccountButtonPressed:(UIButton *)sender;

@end
