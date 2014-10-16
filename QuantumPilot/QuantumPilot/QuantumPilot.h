#import "CCNode.h"
#import "cocos2d.h"
#import "QPBulletDelegate.h"
#import "Bullet.h"
#define QPBF_PLAYER_TAP_RANGE 80
#import "Weapon.h"
#import "Debris.h"

@protocol QuantumPilotingDelegate;

@class QuantumClone;


@interface QuantumPilot : CCNode {
    CGPoint outerEdges[4];
    float radius;
    float innerRadius;
    CGPoint drawingDeltas[4551];
    int drawFrameTotal;
}

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) CGPoint t;
@property (nonatomic, readonly) float speed;
@property (nonatomic) BOOL firing;

@property (nonatomic) int debris;

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

@property (nonatomic) int shield;

- (BOOL)isFiring;

- (void)pulse;
- (void)fire;
- (void)addWaypoint:(CGPoint)l;
- (void)stationaryFire;
- (void)resetIterations;

- (CGPoint)deltasAtIndex:(NSInteger)index;
- (CGPoint)deltaTarget;

- (BOOL)isCollidingWithBullet:(Bullet *)b;
- (bool)processBullet:(Bullet *)b;

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

- (void)installWeapon;
- (void)installWeapon:(NSString *)w;
- (void)installShield;

- (void)setShipDrawColor;

- (void)setShipDrawColor;

- (void)setSpeed:(float)speed;

- (BOOL)processDebris:(Debris *)d;

- (void)defineEdges;

- (void)assignInnerCircleRadius;

- (void)prepareDeltaDraw;

@end

@protocol QuantumPilotingDelegate <NSObject>

- (void)pilotReachedEndOfFutureWaypoints;

@end
