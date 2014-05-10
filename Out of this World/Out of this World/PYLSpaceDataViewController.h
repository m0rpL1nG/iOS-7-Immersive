//
//  PYLSpaceDataViewController.h
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 10/05/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYLSpaceObject.h"

@interface PYLSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) PYLSpaceObject *spaceObject;

@end
