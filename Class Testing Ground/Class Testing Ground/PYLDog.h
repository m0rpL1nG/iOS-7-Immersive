//
//  PYLDog.h
//  Class Testing Ground
//
//  Created by Pierre-Yves LEBECQ on 09/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PYLDog : NSObject
{
    NSString *_name;
}

//@property (strong, nonatomic) NSString *name;

- (void)setName:(NSString *)name;
- (NSString *)name;


@end
