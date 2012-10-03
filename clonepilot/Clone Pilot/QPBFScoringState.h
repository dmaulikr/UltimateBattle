#import "QPBFState.h"
#import "QPBFScoringConstants.h"
#import "QPScoreDisplay.h"

@interface QPBFScoringState : QPBFState

@property (nonatomic, assign) NSInteger scoringStateTime;
@property (nonatomic, retain) QPScoreDisplay *scoreDisplay;

- (NSInteger)timeBonus;
- (NSInteger)accuracyBonus;

@end
