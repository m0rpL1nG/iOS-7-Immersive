//
//  PYLPuppy.m
//  Man's Best Friend
//
//  Created by Pierre-Yves LEBECQ on 09/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLPuppy.h"

@implementation PYLPuppy

- (void)givePuppyEyes
{
    NSLog(@":(");
}

- (void)bark
{
    [super bark];

    NSLog(@"whimper whimper");

    [self givePuppyEyes];
}

@end
