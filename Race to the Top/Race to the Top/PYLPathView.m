//
//  PYLPathView.m
//  Race to the Top
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLPathView.h"
#import "PYLMountainPath.h"

@implementation PYLPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }

    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for (UIBezierPath *path in [PYLMountainPath mountainPathsForRect:self.bounds]) {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}

@end
