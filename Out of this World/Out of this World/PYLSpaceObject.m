//
//  PYLSpaceObject.m
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLSpaceObject.h"
#import "AstronomicalData.h"

@implementation PYLSpaceObject

- (id)init
{
    self = [self initWithData:nil andImage:nil];

    return self;
}

- (id)initWithData:(NSDictionary *)data andImage:(UIImage *)image
{
    self = [super init];

    if (self) {
        self.name = data[PLANET_NAME];
        self.gravitationalForce = [data[PLANET_GRAVITY] floatValue];
        self.diameter = [data[PLANET_DIAMETER] floatValue];
        self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
        self.dayLength = [data[PLANET_DAY_LENGTH] floatValue];
        self.temperature = [data[PLANET_TEMPERATURE] floatValue];
        self.numberOfMoons = [data[PLANET_NUMBER_OF_MOONS] integerValue];
        self.nickname = data[PLANET_NICKNAME];
        self.interestingFact = data[PLANET_INTERESTING_FACT];

        self.image = image;
    }

    return self;
}

@end
