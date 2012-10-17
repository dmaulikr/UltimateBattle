#import "ClonePilot.h"
#import "cocos2d.h"
#import "BulletDelegateProtocol.h"

@interface QuantumClone : CCNode <NSCopying> {
    BOOL _fireDelta[4001];
    CGPoint _deltas[4001];
}

@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, assign) NSInteger turnCount;
@property (nonatomic, assign) NSInteger timeIndex;
@property (nonatomic, assign) NSInteger timeDirection;
@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) BOOL living;

- (void)tick;
- (BOOL)fireDeltaAtIndex:(NSInteger)index;
- (void)addDeltas:(CGPoint)l firing:(BOOL)firing index:(NSInteger)index;
- (NSInteger)identifier;
- (void)reset;
- (BOOL)shipHitByBullet:(Bullet *)b;
- (void)ceaseLiving;

@end

