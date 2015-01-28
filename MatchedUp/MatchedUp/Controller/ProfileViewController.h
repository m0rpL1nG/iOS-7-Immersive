//
//  ProfileViewController.h
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol ProfileViewControllerDelegate <NSObject>

@required

- (void)didPressLike;
- (void)didPressDislike;

@end

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;
@property (weak, nonatomic) id <ProfileViewControllerDelegate> delegate;

@end
