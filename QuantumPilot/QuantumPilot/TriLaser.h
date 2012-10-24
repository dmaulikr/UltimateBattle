//
//  TriLaser.h
//  QuantumPilot
//
//  Created by X3N0 on 10/23/12.
//
//

#import "Bullet.h"

@interface TriLaser : Bullet {
        CGPoint lines[6];
}

@property (nonatomic) NSInteger xDirection;

@end
