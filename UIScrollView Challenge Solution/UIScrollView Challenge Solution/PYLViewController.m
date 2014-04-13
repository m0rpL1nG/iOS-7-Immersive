//
//  PYLViewController.m
//  UIScrollView Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 13/04/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.globeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"world-map.jpeg"]];
    self.scrollView.contentSize = self.globeImageView.frame.size;
    [self.scrollView addSubview:self.globeImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.globeImageView;
}

@end
