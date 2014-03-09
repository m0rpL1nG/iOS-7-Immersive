//
//  PYLDog.h
//  Man's Best Friend
//
//  Created by Pierre-Yves LEBECQ on 08/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PYLDog : NSObject

@property (nonatomic) int age;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *breed;
@property (strong, nonatomic) UIImage *image;

- (void)bark;

@end
