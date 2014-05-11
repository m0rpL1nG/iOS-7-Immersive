//
//  PYLAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 10/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLSpaceObject.h"

@protocol PYLAddSpaceObjectViewControllerDelegage <NSObject>

@required
- (void)addSpaceObject:(PYLSpaceObject *)spaceObject;
- (void)didCancel;

@end

@interface PYLAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <PYLAddSpaceObjectViewControllerDelegage> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;

@end
