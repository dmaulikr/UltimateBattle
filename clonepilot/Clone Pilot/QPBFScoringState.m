#import "QPBFScoringState.h"
#import "QPBattlefield.h"

@implementation QPBFScoringState

- (NSInteger)timeBonus {
    return (QPBF_MAX_TIME - self.f.time) * QPBF_TIME_BONUS_MODIFIER;
}

@end
