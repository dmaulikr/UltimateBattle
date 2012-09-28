#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)tick {
    if (self.f.fightingIteration > 0) {
        [self.f setXDelta:0 atIndex:self.f.fightingIteration];
        [self.f setYDelta:0 atIndex:self.f.fightingIteration];
        for (int i = 0; i < self.f.fightingIteration; i++) {
                CGPoint delta = ccp([self.f xDelta:i+1], [self.f yDelta:i+1]);
                [self.f setXDelta:delta.x atIndex:i];
                [self.f setYDelta:delta.y atIndex:i];
        }
            self.f.fightingIteration--;
    }
}

@end
