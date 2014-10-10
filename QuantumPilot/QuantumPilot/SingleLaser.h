//
//  SingleLaser.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "Bullet.h"

@interface SingleLaser : Bullet {
    CGPoint lines[4];
    int _facing;
}

- (void)setDrawColor;

@end
