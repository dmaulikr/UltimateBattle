#import "QPBFCloningState.h"
#import "QPBattlefield.h"

@implementation QPBFCloningState

- (void)tick {
    [self.f activateNewClone];
    [self.f changeState:self.f.scoringState];
}

@end
