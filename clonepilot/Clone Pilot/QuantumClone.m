#import "QuantumClone.h"

@implementation QuantumClone

- (BOOL)fireDeltaAtIndex:(NSInteger)index {
    return _fireDelta[index];
}
- (void)addDeltas:(CGPoint)l firing:(BOOL)firing index:(NSInteger)index {
    _deltas[index] = l;
}


@end
