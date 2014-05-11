//
//  PYLViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 11/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAccount.h"

@interface PYLViewController : UIViewController

@property (strong, nonatomic) PYLAccount *account;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;

@end
