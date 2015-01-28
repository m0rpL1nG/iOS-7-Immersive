//
//  ProfileViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "ProfileViewController.h"
#import "Constants.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLineLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    PFFile *pictureFile = self.photo[kPhotoPictureKey];
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
    }];

    PFUser *user = self.photo[kPhotoUserKey];
    self.locationLabel.text = user[kUserProfileKey][kUserProfileLocationKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kUserProfileKey][kUserProfileAgeKey]];

    if (user[kUserProfileKey][kUserProfileRelationshipStatusKey] == nil) {
        self.statusLabel.text = @"Single";
    } else {
        self.statusLabel.text = user[kUserProfileKey][kUserProfileRelationshipStatusKey];
    }

    self.tagLineLabel.text = user[kUserTagLineKey];

    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
    self.title = user[kUserProfileKey][kUserProfileFirstNameKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)likeButtonPressed:(UIButton *)sender
{
    [self.delegate didPressLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    [self.delegate didPressDislike];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
