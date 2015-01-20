//
//  HomeViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>

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

    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query includeKey:@"user"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
}

#pragma mark - Helper methods

- (void)queryForCurrentPhotoIndex
{
    if ([self.photos count] > 0) {
        self.photo = self.photos[self.currentPhotoIndex];
        PFFile *file = self.photo[@"image"];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.photoImageView.image = image;
                [self updateView];
            } else {
                NSLog(@"%@", error);
            }
        }];

        PFQuery *queryForLike = [PFQuery queryWithClassName:@"Activity"];
        [queryForLike whereKey:@"type" equalTo:@"like"];
        [queryForLike whereKey:@"photo" equalTo:self.photo];
        [queryForLike whereKey:@"fromUser" equalTo:[PFUser currentUser]];

        PFQuery *queryForDislike = [PFQuery queryWithClassName:@"Activity"];
        [queryForDislike whereKey:@"type" equalTo:@"dislike"];
        [queryForDislike whereKey:@"photo" equalTo:self.photo];
        [queryForDislike whereKey:@"fromUser" equalTo:[PFUser currentUser]];

        PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
        [likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.activities = [objects mutableCopy];

                if (![self.activities count]) {
                    self.isLikedByCurrentUser = NO;
                    self.isDislikedByCurrentUser = NO;
                } else {
                    PFObject *activity = [self.activities firstObject];
                    if ([activity[@"type"] isEqualToString:@"like"]) {
                        self.isLikedByCurrentUser = YES;
                        self.isDislikedByCurrentUser = NO;
                    } else if ([activity[@"type"] isEqualToString:@"dislike"]) {
                        self.isLikedByCurrentUser = NO;
                        self.isDislikedByCurrentUser = YES;
                    } else {
                        // Other type of activity not implemented yet
                    }
                }

                self.likeButton.enabled = YES;
                self.dislikeButton.enabled = YES;
            }
        }];
    }
}

- (void)updateView
{
    self.firstNameLabel.text = self.photo[@"user"][@"profile"][@"first_name"];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[@"user"][@"profile"][@"age"]];
    self.tagLineLabel.text = self.photo[@"user"][@"tagLine"];
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
    PFObject *activity = [PFObject objectWithClassName:@"Activity"];
    [activity setObject:type forKey:@"type"];
    [activity setObject:[PFUser currentUser] forKey:@"fromUser"];
    [activity setObject:[self.photo objectForKey:@"user"] forKey:@"toUser"];
    [activity setObject:self.photo forKey:@"photo"];
    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = [type isEqualToString:@"like"] ? YES : NO;
        self.isDislikedByCurrentUser = [type isEqualToString:@"like"] ? NO : YES;
        [self.activities addObject:activity];
        [self setupNextPhoto];
    }];
}

- (void)checkActivity:(NSString *)type
{
    // First case : the activity is the same as previously
    if (([type isEqualToString:@"like"] && self.isLikedByCurrentUser)
        || ([type isEqualToString:@"dislike"] && self.isDislikedByCurrentUser)) {
        [self setupNextPhoto];

        return;
    }

    // Second case : the activity is not the same, we delete previous activity before saving the new one
    if (([type isEqualToString:@"like"] && self.isDislikedByCurrentUser)
        || ([type isEqualToString:@"dislike"] && self.isLikedByCurrentUser)) {
        for (PFObject *activity in self.activities) {
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
    }

    [self saveActivity:type];
}

@end
