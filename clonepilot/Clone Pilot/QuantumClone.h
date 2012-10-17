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
@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) CGPoint vel;

- (BOOL)fireDeltaAtIndex:(NSInteger)index;
- (void)addDeltas:(CGPoint)l firing:(BOOL)firing index:(NSInteger)index;

@end
