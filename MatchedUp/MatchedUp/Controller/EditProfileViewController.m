//
//  EditProfileViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 20/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface EditProfileViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tagLineTextView.delegate = self;

    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];

    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]) {
            PFObject *photo = [objects firstObject];
            PFFile *file = photo[kPhotoPictureKey];
            [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
        }
    }];

    self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kUserTagLineKey];
}

- (void)didReceiveMemoryWarning {
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

#pragma mark - UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.tagLineTextView resignFirstResponder];

        [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kUserTagLineKey];
        [[PFUser currentUser] saveInBackground];

        [self.navigationController popViewControllerAnimated:YES];
        
        return NO;
    }

    return YES;
}

@end
