//
//  MatchViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 21/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "MatchViewController.h"

@interface MatchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *matchedUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentUserImageView;
@property (weak, nonatomic) IBOutlet UIButton *viewChatsButton;
@property (weak, nonatomic) IBOutlet UIButton *keepSearchingButton;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - IBActions

- (IBAction)viewChatsButtonPressed:(UIButton *)sender
{
}

- (IBAction)keepSearchingButtonPressed:(UIButton *)sender
{
}


@end
