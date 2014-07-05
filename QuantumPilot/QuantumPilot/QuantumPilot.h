#import "CCNode.h"
#import "cocos2d.h"
#import "QPBulletDelegate.h"
#import "Bullet.h"
#define QPBF_PLAYER_TAP_RANGE 80
#import "Weapon.h"

@protocol QuantumPilotingDelegate;

@class QuantumClone;


@interface QuantumPilot : CCNode {
    CGPoint outerEdges[4];
}

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) CGPoint t;
@property (nonatomic, readonly) float speed;
@property (nonatomic) BOOL firing;

@property (nonatomic) CGPoint innerTopEdge;

@property (nonatomic) NSInteger fightingIteration;
@property (nonatomic) NSInteger drawingIteration;
@property (nonatomic) NSInteger time;
@property (nonatomic, copy) NSString *weapon;

@property (nonatomic, retain) QuantumClone *clone;

@property (nonatomic, strong) NSString *bulletName;

@property (nonatomic, assign) id <QPBulletDelegate> bulletDelegate;
@property (nonatomic, assign) id <QuantumPilotingDelegate> pilotDelegate;

@property (strong, nonatomic) Class bulletClass;

@property (nonatomic) BOOL active;
@property (nonatomic) BOOL blinking;

- (BOOL)isFiring;

- (void)pulse;
- (void)fire;
- (void)addWaypoint:(CGPoint)l;
- (void)stationaryFire;
- (void)resetIterations;

- (CGPoint)deltasAtIndex:(NSInteger)index;
- (CGPoint)deltaTarget;

- (BOOL)isCollidingWithBullet:(Bullet *)b;
- (void)processBullet:(Bullet *)b;

- (CGPoint *)drawShape;

- (BOOL)touchesPoint:(CGPoint)l;

- (void)createClone;

- (NSInteger)yDirection;

- (void)moveByVelocity;

- (void)resetPosition;

- (void)checkForFiringWeapon;

- (void)sendBulletsToBattlefield;

- (NSInteger)fireDirection;

- (void)engage;

- (void)drawCircle;

- (bool)shouldDraw ;

+ (CGPoint)resetPosition;

@end

@protocol QuantumPilotingDelegate <NSObject>

- (void)pilotReachedEndOfFutureWaypoints;

@end
