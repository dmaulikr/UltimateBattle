#import "ClonePilot.h"

@interface QuantumClone : ClonePilot {
    float _xDelta[4001];
    float _yDelta[4001];
    BOOL _fireDelta[4001];
}

- (float)xDelta:(NSInteger)index;
- (float)yDelta:(NSInteger)index;
- (BOOL)fireDeltaAtIndex:(NSInteger)index;

- (void)setXDelta:(float)delta atIndex:(NSInteger)index;
- (void)setYDelta:(float)delta atIndex:(NSInteger)index;
- (void)setFireDelta:(BOOL)delta atIndex:(NSInteger)index;

@end
