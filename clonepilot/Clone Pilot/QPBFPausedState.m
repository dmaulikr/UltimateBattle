#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)tick {
    if (self.f.fightingIteration == 0) {
        return;
    }
    
    //How many times do we loop?
    [self.f setXDelta:0 atIndex:self.f.fightingIteration];
    [self.f setYDelta:0 atIndex:self.f.fightingIteration];
    for (int i = 0; i < self.f.fightingIteration; i++) {
        for (int j = 0; j < self.f.fightingIteration; j++) {
            CGPoint delta = ccp([self.f xDelta:j+1], [self.f yDelta:j+1]);
            [self.f setXDelta:delta.x atIndex:j];
            [self.f setYDelta:delta.y atIndex:j];
        }
    }
    
    self.f.fightingIteration = 0;
}

@end
