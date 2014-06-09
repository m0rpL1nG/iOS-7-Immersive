//
//  PYLMountainPath.h
//  Race to the Top
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PYLMountainPath : NSObject

+ (NSArray *)mountainPathsForRect:(CGRect)rect;
+ (UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;

@end
