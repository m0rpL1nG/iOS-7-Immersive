//
//  PYLViewController.m
//  Pirate Adventure
//
//  Created by Pierre-Yves LEBECQ on 15/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLFactory.h"
#import "PYLTile.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    PYLFactory *factory = [[PYLFactory alloc] init];
    self.tiles = [factory tiles];
    self.character = [factory character];
    self.boss = [factory boss];
    self.currentPoint = CGPointMake(0, 0);

    [self updateCharacterStatsForArmor:nil withWeapon:nil withHealthEffect:0];
    [self updateTile];
    [self updateButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)actionButtonPressed:(UIButton *)sender
{
    PYLTile *tile = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];

    // Handle boss tile
    if (tile.healthEffect == -15) {
        self.boss.health -= self.character.damage;
    }

    [self updateCharacterStatsForArmor:tile.armor withWeapon:tile.weapon withHealthEffect:tile.healthEffect];

    if (self.character.health <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Death message" message:@"You have died. Please restart the game." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (self.boss.health <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victory message" message:@"You have defeated the evil pirate boss." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    [self updateTile];
}

- (IBAction)northButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y + 1);

    [self updateButtons];
    [self updateTile];
}

- (IBAction)westButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x - 1, self.currentPoint.y);

    [self updateButtons];
    [self updateTile];
}

- (IBAction)southButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y - 1);

    [self updateButtons];
    [self updateTile];
}

- (IBAction)eastButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x + 1, self.currentPoint.y);

    [self updateButtons];
    [self updateTile];
}

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    self.character = nil;
    self.boss = nil;
    [self viewDidLoad];
}

#pragma mark - helper methods

- (void)updateTile
{
    PYLTile *tile = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];

    self.storyLabel.text = tile.story;
    self.backgroundImageView.image = tile.backgroundImage;
    self.healthLabel.text = [NSString stringWithFormat:@"%i", self.character.health];
    self.damageLabel.text = [NSString stringWithFormat:@"%i", self.character.damage];
    self.armorLabel.text = self.character.armor.name;
    self.weaponLabel.text = self.character.weapon.name;
    [self.actionButton setTitle:tile.actionButtonName forState:UIControlStateNormal];
}

- (void)updateButtons
{
    self.westButton.hidden  = ![self tileExistsAtPoint:CGPointMake(self.currentPoint.x - 1, self.currentPoint.y)];
    self.eastButton.hidden  = ![self tileExistsAtPoint:CGPointMake(self.currentPoint.x + 1, self.currentPoint.y)];
    self.northButton.hidden = ![self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y + 1)];
    self.southButton.hidden = ![self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y - 1)];
}

- (BOOL)tileExistsAtPoint:(CGPoint)point
{
    if (point.y >= 0 && point.x >= 0 && point.x < [self.tiles count] && point.y < [[self.tiles objectAtIndex:point.x] count]) {
        return YES;
    }

    return NO;
}

- (void)updateCharacterStatsForArmor:(PYLArmor *)armor withWeapon:(PYLWeapon *)weapon withHealthEffect:(int)healthEffect
{
    if (armor) {
        self.character.health = self.character.health - self.character.armor.health + armor.health;
        self.character.armor = armor;
    } else if (weapon) {
        self.character.damage = self.character.damage - self.character.weapon.damage + weapon.damage;
        self.character.weapon = weapon;
    } else if (healthEffect != 0) {
        self.character.health = self.character.health + healthEffect;
    } else {
        self.character.health = self.character.health + self.character.armor.health;
        self.character.damage = self.character.damage + self.character.weapon.damage;
    }
}

@end
