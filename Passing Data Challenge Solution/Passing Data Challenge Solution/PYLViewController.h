//
//  PYLViewController.h
//  Passing Data Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 13/04/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLDetailViewController.h"

@interface PYLViewController : UIViewController <PYLDetailViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
