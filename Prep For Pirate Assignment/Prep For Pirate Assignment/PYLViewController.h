//
//  PYLViewController.h
//  Prep For Pirate Assignment
//
//  Created by Pierre-Yves LEBECQ on 09/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAwesomeClass.h"

@interface PYLViewController : UIViewController

@property (nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) IBOutlet UIButton *myButton;
@property (strong, nonatomic) PYLAwesomeClass *awesomeClass;

@end
