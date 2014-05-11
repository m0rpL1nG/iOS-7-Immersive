//
//  PYLDetailViewController.h
//  Passing Data Challenge Solution
//
//  Created by Pierre-Yves LEBECQ on 13/04/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PYLDetailViewControllerDelegate <NSObject>

@required
- (void)didUpdateText:(NSString *)text;

@end

@interface PYLDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSString *textToDisplay;
@property (weak, nonatomic) id <PYLDetailViewControllerDelegate> delegate;

- (IBAction)updateButtonPressed:(UIButton *)sender;

@end
