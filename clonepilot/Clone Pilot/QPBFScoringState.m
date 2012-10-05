#import "QPBFScoringState.h"
#import "QPBattlefield.h"
#import "QPBFDisplayConstants.h"

@interface QPBFScoringState()

- (void)removeScoreDisplay;

@end

@implementation QPBFScoringState

@synthesize scoringStateTime = _scoringStateTime;
@synthesize scoreDisplay = _scoreDisplay;

- (void)tick {
    if (!self.scoreDisplay) {
        self.scoreDisplay = [[[QPScoreDisplay alloc] initWithTimeBonus:[self timeBonus]
                                                         accuracyBonus:[self accuracyBonus]
                                                                 layer:self.f.layer] autorelease];
    }
    self.scoringStateTime++;
    
    if (self.scoringStateTime == QPBF_SCORING_CONTINUE_DELAY && !self.scoreDisplay.continueLabel) {
        [self.scoreDisplay showContinueLabel];
    }
}

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

- (void)removeScoreDisplay {
    if (self.scoreDisplay) {
        [_scoreDisplay removeFromParentAndCleanup:YES];
        [_scoreDisplay release];
        _scoreDisplay = nil;
    }
}

- (void)dealloc {
    [self removeScoreDisplay];
    [super dealloc];
}

@end
