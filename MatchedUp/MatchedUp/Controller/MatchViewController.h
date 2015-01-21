//
//  MatchViewController.h
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 21/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatchViewControllerDelegate <NSObject>

@required
- (void)presentMatchesViewController;

@end

@interface MatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak, nonatomic) id <MatchViewControllerDelegate> delegate;

@end
