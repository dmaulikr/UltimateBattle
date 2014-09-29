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

- (void)setColor {
    [WideSpiralLaserCannon setDrawColor];
}

@end
