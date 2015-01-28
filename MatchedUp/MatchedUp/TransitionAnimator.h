//
//  TransitionAnimator.h
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 28/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

@end
