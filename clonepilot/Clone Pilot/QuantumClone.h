#import "ClonePilot.h"
#import "cocos2d.h"

@interface QuantumClone : CCNode {
    BOOL _fireDelta[4001];
    CGPoint _deltas[4001];
}

- (BOOL)fireDeltaAtIndex:(NSInteger)index;
- (void)addDeltas:(CGPoint)l firing:(BOOL)firing index:(NSInteger)index;

@end
