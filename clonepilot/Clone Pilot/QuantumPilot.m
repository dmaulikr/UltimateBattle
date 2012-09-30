#import "QuantumPilot.h"

@implementation QuantumPilot
@synthesize firing = _firing;

- (void)fire {
    self.firing = YES;
    [self.bulletDelegate fired];
}

- (BOOL)isFiring {
    return self.firing;
}

@end
