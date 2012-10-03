#import "QPBFScoringState.h"
#import "QPBattlefield.h"

@implementation QPBFScoringState

- (NSInteger)timeBonus {
    return (QPBF_MAX_TIME - self.f.time) * QPBF_TIME_BONUS_MODIFIER;
}

- (NSInteger)accuracyBonus {
    float accuracy = self.f.hits / self.f.shotsFired;
    float accuracyScore = accuracy * QPBF_ACCURACY_BONUS_MODIFIER;
    
    if (accuracy >= 1) {
        accuracyScore *= QPBF_ACCURACY_PERFECT_BONUS_MULTIPLIER;
    }
    
    return ceilf(accuracyScore);
}

@end
