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
#import "MatchViewController.h"

@interface HomeViewController () <MatchViewControllerDelegate, ProfileViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
@property (weak, nonatomic) IBOutlet UIView *labelContainerView;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;

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

    [self setUpViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.photoImageView.image = nil;
    self.firstNameLabel.text = nil;
    self.ageLabel.text = nil;

    self.currentPhotoIndex = 0;

    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey notEqualTo:[PFUser currentUser]];
    [query includeKey:kPhotoUserKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.photos = objects;
            if (![self allowPhoto]) {
                [self setupNextPhoto];
            } else {
                [self queryForCurrentPhotoIndex];
            }
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];

    [self addShadowForView:self.buttonContainerView];
    [self addShadowForView:self.labelContainerView];
    self.photoImageView.layer.masksToBounds = YES;
}

- (void)addShadowForView:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 4;
    view.layer.shadowRadius = 1;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.25;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"homeToProfileSegue"]) {
        ProfileViewController *profileVC = [segue destinationViewController];
        profileVC.photo = self.photo;
        profileVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"homeToMatchSegue"]) {
        MatchViewController *matchVC = segue.destinationViewController;
        matchVC.matchedUserImage = self.photoImageView.image;
        matchVC.delegate = self;
    }
}

#pragma mark - IBActions

- (IBAction)chatBarbuttonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
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
}

- (void)setupNextPhoto
{
    if (self.currentPhotoIndex + 1 < [self.photos count]) {
        self.currentPhotoIndex++;
        if ([self allowPhoto]) {
            [self queryForCurrentPhotoIndex];
        } else {
            [self setupNextPhoto];
        }

        return;
    }

    [[[UIAlertView alloc] initWithTitle:@"No more users to view" message:@"Check back later for more people" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (BOOL)allowPhoto
{
    int maxAge = [[NSUserDefaults standardUserDefaults] integerForKey:kSettingsAgeMaxKey];
    BOOL men = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsMenEnabledKey];
    BOOL women = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsWomenEnabledKey];
    BOOL singles = [[NSUserDefaults standardUserDefaults] boolForKey:kSettingsSingleEnabledKey];

    PFObject *photo = self.photos[self.currentPhotoIndex];
    PFUser *user = photo[kPhotoUserKey];
    int userAge = [user[kUserProfileKey][kUserProfileAgeKey] intValue];
    NSString *gender = user[kUserProfileKey][kUserProfileGenderKey];
    NSString *relationshipStatus = user[kUserProfileKey][kUserProfileRelationshipStatusKey];

    if (
        userAge > maxAge
        || (men == NO && [gender isEqualToString:@"male"])
        || (women == NO && [gender isEqualToString:@"female"])
        || (singles == NO && ([relationshipStatus isEqualToString:@"single"] || relationshipStatus == nil))
    ) {
        return NO;
    }

    return YES;
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
        // If this is a like, we check whether it's a match or not
        if ([type isEqualToString:kActivityTypeLikeKey]) {
            [self checkForPhotoUserLikes];
        }
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

- (void)checkForPhotoUserLikes
{
    PFQuery *query = [PFQuery queryWithClassName:kActivityClassKey];
    [query whereKey:kActivityFromUserKey equalTo:self.photo[kPhotoUserKey]];
    [query whereKey:kActivityToUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kActivityTypeKey equalTo:kActivityTypeLikeKey];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]) {
            [self createChatRoom];
        }
    }];
}

- (void)createChatRoom
{
    PFQuery *queryForChatRoom = [PFQuery queryWithClassName:kChatRoomClassKey];
    [queryForChatRoom whereKey:kChatRoomUser1Key equalTo:[PFUser currentUser]];
    [queryForChatRoom whereKey:kChatRoomUser2Key equalTo:self.photo[kPhotoUserKey]];

    PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:kChatRoomClassKey];
    [queryForChatRoom whereKey:kChatRoomUser1Key equalTo:self.photo[kPhotoUserKey]];
    [queryForChatRoom whereKey:kChatRoomUser2Key equalTo:[PFUser currentUser]];

    PFQuery *query = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (0 == [objects count]) {
            PFObject *chatroom = [PFObject objectWithClassName:kChatRoomClassKey];
            [chatroom setObject:[PFUser currentUser] forKey:kChatRoomUser1Key];
            [chatroom setObject:self.photo[kPhotoUserKey] forKey:kChatRoomUser2Key];
            [chatroom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self performSegueWithIdentifier:@"homeToMatchSegue" sender:nil];
            }];
        }
    }];
}

#pragma mark - MatchViewControllerDelegate methods

- (void)presentMatchesViewController
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
    }];
}

#pragma mark - ProfileViewControllerDelegate methods

- (void)didPressLike
{
    [self.navigationController popViewControllerAnimated:NO];

    [self checkActivity:kActivityTypeLikeKey];
}

- (void)didPressDislike
{
    [self.navigationController popViewControllerAnimated:NO];

    [self checkActivity:kActivityTypeDislikeKey];
}

@end
