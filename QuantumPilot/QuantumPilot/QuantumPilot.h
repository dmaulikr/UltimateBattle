//
//  QuantumPilot.h
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "CCNode.h"
@class QuantumClone;

@interface QuantumPilot : CCNode {
    
}

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) CGPoint t;
@property (nonatomic, readonly) float speed;
@property (nonatomic) BOOL firing;

@property (nonatomic) NSInteger fightingIteration;
@property (nonatomic) NSInteger drawingIteration;

@property (nonatomic, retain) QuantumClone *clone;

- (void)tick;

- (BOOL)isFiring;

- (void)addWaypoint:(CGPoint)l;

//////////

- (BOOL)isCollidingWithBullet;
//- (void)hitByBullet:


@end
