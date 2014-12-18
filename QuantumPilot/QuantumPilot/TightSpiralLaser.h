//
//  TightSpiralLaser.h
//  QuantumPilot
//
//  Created by quantum on 26/09/2014.
//
//

#import "Bullet.h"

@interface TightSpiralLaser : Bullet {
    int _xDirection;
    int _yDirection;
    CGPoint lines[2];
    int side;
    int ox;
    int delay;
}

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity centerX:(int)x;

- (void)oscillate;

- (float)oscillateSpeed;

- (void)setColor;

- (NSInteger)delayReset;

@end
