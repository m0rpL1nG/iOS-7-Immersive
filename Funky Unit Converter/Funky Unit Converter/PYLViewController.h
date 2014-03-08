//
//  PYLViewController.h
//  Funky Unit Converter
//
//  Created by Pierre-Yves LEBECQ on 08/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYLViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *numberOfBillsLabel;
@property (strong, nonatomic) IBOutlet UITextField *numberOfFieldsTextField;
- (IBAction)convertUnits:(UIButton *)sender;

@end
