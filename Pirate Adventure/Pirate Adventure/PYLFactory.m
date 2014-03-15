//
//  PYLFactory.m
//  Pirate Adventure
//
//  Created by Pierre-Yves LEBECQ on 15/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLFactory.h"
#import "PYLTile.h"

@implementation PYLFactory

- (NSArray *)tiles
{
    PYLTile *tile1 = [[PYLTile alloc] init];
    tile1.story = @"Captain, we need a fearless leader such as yourself to undertake a voyage. You just stop the evil pirate Boss. Would you like a blunted sword to get started ?";
    tile1.backgroundImage = [UIImage imageNamed:@"PirateStart.jpg"];
    PYLWeapon *bluntedSword = [[PYLWeapon alloc] init];
    bluntedSword.name = @"Blunted Sword";
    bluntedSword.damage = 12;
    tile1.weapon = bluntedSword;
    tile1.actionButtonName = @"Take the sword";

    PYLTile *tile2 = [[PYLTile alloc] init];
    tile2.story = @"You have come across an armory. Would you like to upgrade your armor to steel armor ?";
    tile2.backgroundImage = [UIImage imageNamed:@"PirateBlacksmith.jpeg"];
    PYLArmor *steelArmor = [[PYLArmor alloc] init];
    steelArmor.name = @"Steel armor";
    steelArmor.health = 8;
    tile2.armor = steelArmor;
    tile2.actionButtonName = @"Take armor";

    PYLTile *tile3 = [[PYLTile alloc] init];
    tile3.story = @"A mysterious dock appears on the horizon. Should we stop and ask for directions ?";
    tile3.backgroundImage = [UIImage imageNamed:@"PirateFriendlyDock.jpg"];
    tile3.healthEffect = 12;
    tile3.actionButtonName = @"Stop at the dock";

    NSArray *firstColumn = [[NSArray alloc] initWithObjects:tile1, tile2, tile3, nil];

    PYLTile *tile4 = [[PYLTile alloc] init];
    tile4.story = @"You have found a perrot. This can be used in your armor slot. Parrots are a great defender and are fiercly loyal to their captain !";
    tile4.backgroundImage = [UIImage imageNamed:@"PirateParrot.jpg"];
    PYLArmor *parrotArmor = [[PYLArmor alloc] init];
    parrotArmor.health = 20;
    parrotArmor.name = @"Parrot";
    tile4.armor = parrotArmor;
    tile4.actionButtonName = @"Adopt parrot";

    PYLTile *tile5 = [[PYLTile alloc] init];
    tile5.story = @"You have stumbled apon a cache of pirate weapons. Would you like to upgrade to a pistol ?";
    tile5.backgroundImage = [UIImage imageNamed:@"PirateWeapons.jpeg"];
    PYLWeapon *pistol = [[PYLWeapon alloc] init];
    pistol.name = @"Pistol";
    pistol.damage = 17;
    tile5.weapon = pistol;
    tile5.actionButtonName = @"Use pistol";

    PYLTile *tile6 = [[PYLTile alloc] init];
    tile6.story = @"You have been captured by pirates and are ordered to walk the plank.";
    tile6.backgroundImage = [UIImage imageNamed:@"PiratePlank.jpg"];
    tile6.healthEffect = -22;
    tile6.actionButtonName = @"Show no fear";

    NSArray *secondColumn = [[NSArray alloc] initWithObjects:tile4, tile5, tile6, nil];

    PYLTile *tile7 = [[PYLTile alloc] init];
    tile7.story = @"You have sighted a pirate battle off the coast. Should we intervene ?";
    tile7.backgroundImage = [UIImage imageNamed:@"PirateShipBattle.jpeg"];
    tile7.healthEffect = 8;
    tile7.actionButtonName = @"Fight those scum";

    PYLTile *tile8 = [[PYLTile alloc] init];
    tile8.story = @"The legend of the deep. The mighty kraken appears.";
    tile8.backgroundImage = [UIImage imageNamed:@"PirateOctopusAttack.jpg"];
    tile8.healthEffect = -46;
    tile8.actionButtonName = @"Abandon ship";

    PYLTile *tile9 = [[PYLTile alloc] init];
    tile9.story = @"You have stumbled upon a hidden cave of pirate treasurer.";
    tile9.backgroundImage = [UIImage imageNamed:@"PirateTreasure.jpeg"];
    tile9.healthEffect = 20;
    tile9.actionButtonName = @"Take treasure";

    NSArray *thirdColumn = [[NSArray alloc] initWithObjects:tile7, tile8, tile9, nil];

    PYLTile *tile10 = [[PYLTile alloc] init];
    tile10.story = @"A group of pirates attempt to board your ship.";
    tile10.backgroundImage = [UIImage imageNamed:@"PirateAttack.jpg"];
    tile10.healthEffect = -15;
    tile10.actionButtonName = @"Repel the invaders";

    PYLTile *tile11 = [[PYLTile alloc] init];
    tile11.story = @"In the deep of the sea, many things live and many things can be found. Will the fortune bring help or ruin ?";
    tile11.backgroundImage = [UIImage imageNamed:@"PirateTreasurer2.jpeg"];
    tile11.healthEffect = -7;
    tile11.actionButtonName = @"Swim deeper";

    PYLTile *tile12 = [[PYLTile alloc] init];
    tile12.story = @"Your final faceoff with the fearsome pirate boss !";
    tile12.backgroundImage = [UIImage imageNamed:@"PirateBoss.jpeg"];
    tile12.healthEffect = -15;
    tile12.actionButtonName = @"Fight";

    NSArray *fourthColumn = [[NSArray alloc] initWithObjects:tile10, tile1, tile12, nil];

    NSArray *tiles = [[NSArray alloc] initWithObjects:firstColumn, secondColumn, thirdColumn, fourthColumn, nil];

    return tiles;
}

- (PYLCharacter *)character
{
    PYLCharacter *character = [[PYLCharacter alloc] init];

    character.health = 100;

    PYLArmor *armor = [[PYLArmor alloc] init];
    armor.name = @"Cloak";
    armor.health = 5;
    character.armor = armor;

    PYLWeapon *weapon = [[PYLWeapon alloc] init];
    weapon.name = @"Fists";
    weapon.damage = 10;
    character.weapon = weapon;

    return character;
}

- (PYLBoss *)boss
{
    PYLBoss *boss = [[PYLBoss alloc] init];
    boss.health = 65;

    return boss;
}

@end
