//
//  HomeViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "ProfileViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLineLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) PFObject *photo;
@property (strong, nonatomic) NSMutableArray *activities;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.currentPhotoIndex = 0;

    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey notEqualTo:[PFUser currentUser]];
    [query includeKey:kPhotoUserKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.photos = objects;
            [self queryForCurrentPhotoIndex];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"homeToProfileSegue"]) {
        ProfileViewController *profileVC = [segue destinationViewController];
        profileVC.photo = self.photo;
    }
}

#pragma mark - IBActions

- (IBAction)chatBarbuttonItemPressed:(UIBarButtonItem *)sender
{
}

- (IBAction)settingsBarButtonItemPressed:(UIBarButtonItem *)sender
{
}

- (IBAction)likeButtonPressed:(UIButton *)sender
{
    [self checkActivity:@"like"];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    [self checkActivity:@"dislike"];
}

- (IBAction)infoButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
}

#pragma mark - Helper methods

- (void)queryForCurrentPhotoIndex
{
    if ([self.photos count] > 0) {
        self.photo = self.photos[self.currentPhotoIndex];
        PFFile *file = self.photo[kPhotoPictureKey];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.photoImageView.image = image;
                [self updateView];
            } else {
                NSLog(@"%@", error);
            }
        }];

        PFQuery *queryForLike = [PFQuery queryWithClassName:kActivityClassKey];
        [queryForLike whereKey:kActivityTypeKey equalTo:kActivityTypeLikeKey];
        [queryForLike whereKey:kActivityPhotoKey equalTo:self.photo];
        [queryForLike whereKey:kActivityFromUserKey equalTo:[PFUser currentUser]];

        PFQuery *queryForDislike = [PFQuery queryWithClassName:kActivityClassKey];
        [queryForDislike whereKey:kActivityTypeKey equalTo:kActivityTypeDislikeKey];
        [queryForDislike whereKey:kActivityPhotoKey equalTo:self.photo];
        [queryForDislike whereKey:kActivityFromUserKey equalTo:[PFUser currentUser]];

        PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
        [likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.activities = [objects mutableCopy];

                if (![self.activities count]) {
                    self.isLikedByCurrentUser = NO;
                    self.isDislikedByCurrentUser = NO;
                } else {
                    PFObject *activity = [self.activities firstObject];
                    if ([activity[kActivityTypeKey] isEqualToString:kActivityTypeLikeKey]) {
                        self.isLikedByCurrentUser = YES;
                        self.isDislikedByCurrentUser = NO;
                    } else if ([activity[kActivityTypeKey] isEqualToString:kActivityTypeDislikeKey]) {
                        self.isLikedByCurrentUser = NO;
                        self.isDislikedByCurrentUser = YES;
                    } else {
                        // Other type of activity not implemented yet
                    }
                }

                self.likeButton.enabled = YES;
                self.dislikeButton.enabled = YES;
                self.infoButton.enabled = YES;
            }
        }];
    }
}

- (void)updateView
{
    self.firstNameLabel.text = self.photo[kPhotoUserKey][kUserProfileKey][kUserProfileFirstNameKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[kPhotoUserKey][kUserProfileKey][kUserProfileAgeKey]];
    self.tagLineLabel.text = self.photo[kPhotoUserKey][kUserTagLineKey];
}

- (void)setupNextPhoto
{
    if (self.currentPhotoIndex + 1 < [self.photos count]) {
        self.currentPhotoIndex++;
        [self queryForCurrentPhotoIndex];

        return;
    }

    [[[UIAlertView alloc] initWithTitle:@"No more users to view" message:@"Check back later for more people" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)saveActivity:(NSString *)type
{
    PFObject *activity = [PFObject objectWithClassName:kActivityClassKey];
    [activity setObject:type forKey:kActivityTypeKey];
    [activity setObject:[PFUser currentUser] forKey:kActivityFromUserKey];
    [activity setObject:[self.photo objectForKey:kPhotoUserKey] forKey:kActivityToUserKey];
    [activity setObject:self.photo forKey:kActivityPhotoKey];
    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = [type isEqualToString:kActivityTypeLikeKey] ? YES : NO;
        self.isDislikedByCurrentUser = [type isEqualToString:kActivityTypeLikeKey] ? NO : YES;
        [self.activities addObject:activity];
        [self setupNextPhoto];
    }];
}

- (void)checkActivity:(NSString *)type
{
    // First case : the activity is the same as previously
    if (([type isEqualToString:kActivityTypeLikeKey] && self.isLikedByCurrentUser)
        || ([type isEqualToString:kActivityTypeDislikeKey] && self.isDislikedByCurrentUser)) {
        [self setupNextPhoto];

        return;
    }

    // Second case : the activity is not the same, we delete previous activity before saving the new one
    if (([type isEqualToString:kActivityTypeLikeKey] && self.isDislikedByCurrentUser)
        || ([type isEqualToString:kActivityTypeDislikeKey] && self.isLikedByCurrentUser)) {
        for (PFObject *activity in self.activities) {
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
    }

    [self saveActivity:type];
}

@end
