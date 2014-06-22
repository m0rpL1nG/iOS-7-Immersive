//
//  PYLPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Pierre-Yves LEBECQ on 22/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface PYLPhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end
