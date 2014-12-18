//
//  WideSpiralLaser.m
//  QuantumPilot
//
//  Created by quantum on 29/09/2014.
//
//

#import "WideSpiralLaser.h"
#import "WideSpiralLaserCannon.h"

@implementation WideSpiralLaser

- (float)oscillateSpeed {
    return .2;
}

- (NSInteger)delayReset {
    return 31;
}

- (void)setColor {
    [WideSpiralLaserCannon setDrawColor];
}

- (NSString *)weapon {
    return @"WideSpiralLaserCannon";
}


@end
