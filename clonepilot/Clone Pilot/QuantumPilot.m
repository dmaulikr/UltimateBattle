#import "QuantumPilot.h"

@implementation QuantumPilot
@synthesize firing = _firing;

- (void)fire {
    self.firing = YES;
    [self.bulletDelegate fired];
}

- (void)tick {
    if ([self isFiring]) {
        [self fireWeapon];
    }
    
    [self assignVelocityForTarget];
    [self updateLocationWithVelocity];
    
    self.t = self.l;
}

- (BOOL)isFiring {
    return self.firing;
}

@end
