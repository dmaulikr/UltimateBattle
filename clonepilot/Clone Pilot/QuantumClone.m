#import "QuantumClone.h"

@implementation QuantumClone
@synthesize bulletDelegate;
@synthesize turnCount = _turnCount;
@synthesize timeIndex = _timeIndex;
@synthesize l = _l;
@synthesize vel = _vel;

- (id)copyWithZone:(NSZone *)zone {
    QuantumClone *c = [[QuantumClone alloc] init];
    c.turnCount = self.turnCount;
    for (int i = 0; i < self.turnCount; i++) {
        [c addDeltas:_deltas[i]
              firing:_fireDelta[i]
               index:i];
    }
    return c;
}

- (BOOL)fireDeltaAtIndex:(NSInteger)index {
    return _fireDelta[index];
}

- (void)tick {
    self.l = CombinedPoint(self.l, _deltas[self.timeIndex]);
}

- (void)draw {
    NSLog(@"");
}

- (void)addDeltas:(CGPoint)l firing:(BOOL)firing index:(NSInteger)index {
    _deltas[index] = l;
    _fireDelta[index] = firing;
}

- (void)dealloc {
    self.bulletDelegate = nil;
    [super dealloc];
}

@end
