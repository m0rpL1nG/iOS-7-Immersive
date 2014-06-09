//
//  PYLViewController.m
//  Race to the Top
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLViewController.h"
#import "PYLPathView.h"
#import "PYLMountainPath.h"

#define PYLMAP_STARTING_SCORE 15000
#define PYLMAP_SCORE_DECREMENT_AMOUNT 100
#define PYLTIMER_INTERVAL 0.1
#define PYLWALL_PENALTY 500

@interface PYLViewController ()

@property (strong, nonatomic) IBOutlet PYLPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation PYLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];

    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", PYLMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"Tapped");
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"Tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];

    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y >= 750) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:PYLTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", PYLMAP_STARTING_SCORE];
    } else if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        for (UIBezierPath *path in [PYLMountainPath mountainPathsForRect:self.pathView.bounds]) {
            UIBezierPath *tapTarget = [PYLMountainPath tapTargetForPath:path];
            if ([tapTarget containsPoint:fingerLocation]) {
                [self decrementScoreByAmount:PYLWALL_PENALTY];
            }
        }
    } else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165) {
        [self.timer invalidate];
        self.timer = nil;
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top of the path !" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];

        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerFired
{
    [self decrementScoreByAmount:PYLMAP_SCORE_DECREMENT_AMOUNT];
}

- (void)decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score -= amount;

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
}

@end
