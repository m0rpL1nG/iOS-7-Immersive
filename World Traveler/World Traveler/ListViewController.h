//
//  ViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

