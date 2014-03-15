//
//  PYLFactory.h
//  Pirate Adventure
//
//  Created by Pierre-Yves LEBECQ on 15/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYLCharacter.h"
#import "PYLBoss.h"

@interface PYLFactory : NSObject

- (NSArray *)tiles;
- (PYLCharacter *)character;
- (PYLBoss *)boss;

@end
