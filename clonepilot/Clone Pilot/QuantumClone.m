#import "QuantumClone.h"

@implementation QuantumClone

- (float)xDelta:(NSInteger)index {
    return _xDelta[index];
}

- (float)yDelta:(NSInteger)index {
    return _yDelta[index];
}

- (BOOL)fireDeltaAtIndex:(NSInteger)index {
    return _fireDelta[index];
}

- (void)setXDelta:(float)delta atIndex:(NSInteger)index {
    _xDelta[index] = delta;
}

- (void)setYDelta:(float)delta atIndex:(NSInteger)index {
    _yDelta[index] = delta;
}

- (void)setFireDelta:(BOOL)delta atIndex:(NSInteger)index {
    _fireDelta[index] = delta;
}


@end
