#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)tick {
    if (self.f.fightingIteration == 0) {
        return;
    }
    
    [self.f clearUsedDeltas];
}

@end
