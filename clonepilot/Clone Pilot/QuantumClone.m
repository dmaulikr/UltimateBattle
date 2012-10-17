#import "QuantumClone.h"
#import "QPDrawing.h"

@implementation QuantumClone
@synthesize bulletDelegate;
@synthesize turnCount = _turnCount;
@synthesize timeIndex = _timeIndex;
@synthesize l = _l;
@synthesize vel = _vel;
@synthesize living = _living;
@synthesize timeDirection = _timeDirection;

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

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 724);
}

- (void)reset {
    self.living = YES;
    self.timeDirection = 1;
    self.timeIndex = 0;
    self.l = [QuantumClone defaultLocation];
}

- (id)init {
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

+ (NSInteger)identifier {
    return 1;
}

- (NSInteger)identifier {
    return [QuantumClone identifier];
}

- (void)ceaseLiving {
    self.living = NO;
}

- (BOOL)shipHitByBullet:(Bullet *)b {
    CGPoint *shipLines = basicDiamondShipLines(self.l, QP_ClonePilotYDirection);
    return shapeOfSizeContainsPoint(shipLines, 4, b.l);
}

- (BOOL)fireDeltaAtIndex:(NSInteger)index {
    return _fireDelta[index];
}

- (void)tick {
    if (self.living) {
        self.l = CombinedPoint(self.l, _deltas[self.timeIndex]);
    }

    self.timeDirection+= self.timeDirection;
    if (self.timeDirection > self.turnCount || self.timeDirection < 0) {
        self.timeDirection = self.timeDirection * -1;
    }
    
}

- (void)draw {
    drawBasicDiamondShip(self.l, -1);
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
