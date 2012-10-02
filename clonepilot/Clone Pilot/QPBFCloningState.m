#import "QPBFCloningState.h"
#import "QPBattlefield.h"

@implementation QPBFCloningState

- (void)tick {
    [self.f addClone];
    QuantumClone *c = [self.f newestClone];
    c.living = NO;
    for (int i = 0; i < self.f.fightingIteration; i++) {
        [c setXDelta:[self.f xDelta:i] atIndex:i];
        [c setYDelta:[self.f yDelta:i] atIndex:i];
        [c setFireDelta:[self.f fireDeltaAtIndex:i] atIndex:i];
    }
    
    Class weaponClass = [self.f.pilot.weapon class];
    id cloneWeapon = [[weaponClass alloc] init];
    c.weapon = cloneWeapon;
    [cloneWeapon release];
    
    [self.f changeState:self.f.scoringState];
}

@end
