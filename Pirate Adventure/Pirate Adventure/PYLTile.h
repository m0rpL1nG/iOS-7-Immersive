//
//  PYLTile.h
//  Pirate Adventure
//
//  Created by Pierre-Yves LEBECQ on 15/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PYLWeapon.h"
#import "PYLArmor.h"

@interface PYLTile : NSObject

@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) NSString *actionButtonName;
@property (strong, nonatomic) PYLWeapon *weapon;
@property (strong, nonatomic) PYLArmor *armor;
@property (nonatomic) int healthEffect;

@end
