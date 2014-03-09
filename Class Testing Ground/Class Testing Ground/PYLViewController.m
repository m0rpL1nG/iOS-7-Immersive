//
//  PYLViewController.m
//  Class Testing Ground
//
//  Created by Pierre-Yves LEBECQ on 09/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLDog.h"

@interface PYLViewController ()

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *string = @"The NewFoundland dog breed has webbed feet which aids in its swimming prowess";
    NSArray *wordsInSentence = [string componentsSeparatedByString:@" "];
    NSMutableArray *capitalizedWords = [[NSMutableArray alloc] init];
//    for (int word = 0; word < [wordsInSentence count]; word++) {
//        NSString *uncapitalizedWord = [wordsInSentence objectAtIndex:word];
//        NSString *capitalizedWord = [uncapitalizedWord capitalizedString];
//        [capitalizedWords addObject:capitalizedWord];
//    }
//    NSLog(@"%@", capitalizedWords);

//    for (NSString *word in wordsInSentence) {
//        NSString *capitalizedWord = [word capitalizedString];
//        [capitalizedWords addObject:capitalizedWord];
//    }
//    NSLog(@"%@", capitalizedWords);

    PYLDog *dog = [[PYLDog alloc] init];
    [dog setName:@"Sparky"];
    NSString *dogName = [dog name];
    NSLog(@"%@", dogName);
    dog.name = @"Sparky is awesome";
    NSLog(@"%@", dog.name);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
