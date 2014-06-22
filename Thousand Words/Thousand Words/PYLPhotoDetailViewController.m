//
//  PYLPhotoDetailViewController.m
//  Thousand Words
//
//  Created by Pierre-Yves LEBECQ on 22/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLPhotoDetailViewController.h"
#import "Photo.h"
#import "PYLFiltersCollectionViewController.h"

@interface PYLPhotoDetailViewController ()

@end

@implementation PYLPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.imageView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Filter Segue"]) {
        if ([segue.destinationViewController isKindOfClass:[PYLFiltersCollectionViewController class]]) {
            PYLFiltersCollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.photo = self.photo;
        }
    }
}

- (IBAction)addFilterButtonPressed:(UIButton *)sender
{
}

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    NSError *error = nil;
    if (![[self.photo managedObjectContext] save:&error]) {
        // Error in saving
        NSLog(@"%@", error);
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
