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
    CGPoint lines[2];
    int side;
    int ox;
}

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity centerX:(int)x;

@end
