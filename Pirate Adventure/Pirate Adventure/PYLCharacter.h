//
//  PYLCharacter.h
//  Pirate Adventure
//
//  Created by Pierre-Yves LEBECQ on 15/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYLArmor.h"
#import "PYLWeapon.h"

@interface PYLCharacter : NSObject

@property (strong, nonatomic) PYLArmor *armor;
@property (strong, nonatomic) PYLWeapon *weapon;
@property (nonatomic) int damage;
@property (nonatomic) int health;

@end
