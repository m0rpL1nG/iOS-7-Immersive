//
//  FavoriteVenuesViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 06/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteVenuesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
