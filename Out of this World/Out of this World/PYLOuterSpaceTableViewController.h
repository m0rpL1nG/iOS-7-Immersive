//
//  PYLOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLAddSpaceObjectViewController.h"

@interface PYLOuterSpaceTableViewController : UITableViewController <PYLAddSpaceObjectViewControllerDelegage>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
