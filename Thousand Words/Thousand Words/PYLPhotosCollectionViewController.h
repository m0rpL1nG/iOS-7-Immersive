//
//  PYLPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Pierre-Yves LEBECQ on 21/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface PYLPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Album *album;

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
