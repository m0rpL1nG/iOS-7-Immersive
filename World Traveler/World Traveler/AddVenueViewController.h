//
//  AddVenueViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 06/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVenueViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeOfFoodTextField;

- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
