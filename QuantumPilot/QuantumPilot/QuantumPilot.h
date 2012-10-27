#import "CCNode.h"
#import "cocos2d.h"
#import "QPBulletDelegate.h"
#import "Bullet.h"

@protocol QuantumPilotingDelegate;

@class QuantumClone;


@interface QuantumPilot : CCNode {
    CGPoint outerEdges[4];
    CGPoint innerTopEdge;
}

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) CGPoint t;
@property (nonatomic, readonly) float speed;
@property (nonatomic) BOOL firing;

@property (nonatomic) NSInteger fightingIteration;
@property (nonatomic) NSInteger drawingIteration;

@property (nonatomic, retain) QuantumClone *clone;

@property (nonatomic, assign) id <QPBulletDelegate> bulletDelegate;
@property (nonatomic, assign) id <QuantumPilotingDelegate> pilotDelegate;

- (void)tick;

- (BOOL)isFiring;

- (void)addWaypoint:(CGPoint)l;

//////////

- (BOOL)isCollidingWithBullet:(Bullet *)b;
//- (void)hitByBullet:

- (CGPoint *)drawShape;

@end
