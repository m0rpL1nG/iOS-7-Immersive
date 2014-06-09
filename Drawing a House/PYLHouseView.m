//
//  PYLHouseView.m
//  Drawing a House
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLHouseView.h"

@implementation PYLHouseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 2.0;
    [bezierPath moveToPoint:CGPointMake(1 / 4.0 * self.bounds.size.width, 1 / 3.0 * self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(1 / 4.0 * self.bounds.size.width, 2 / 3.0 * self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(3 / 4.0 * self.bounds.size.width, 2 / 3.0 * self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(3 / 4.0 * self.bounds.size.width, 1 / 3.0 * self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(1 / 2.0 * self.bounds.size.width, 1 / 4.0 * self.bounds.size.height)];
    [bezierPath closePath];
    [bezierPath stroke];
}

@end
