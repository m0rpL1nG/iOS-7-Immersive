//
//  DirectionsListViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 04/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *steps;

@end
