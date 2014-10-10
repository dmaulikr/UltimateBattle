//
//  SplitLaser.h
//  QuantumPilot
//
//  Created by X3N0 on 10/23/12.
//
//

#import "Bullet.h"

@interface SplitLaser : Bullet {
    CGPoint lines[2];
    NSInteger segmentIndex[4];
    NSInteger _heldBreaths;
    NSInteger _breathCharge;
    int _xDirection;
    int _yDirection;
}

@end
