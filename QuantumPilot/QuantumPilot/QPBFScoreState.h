//
//  QPBFScoreState.h
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "QPBFState.h"
#import "ScoreDisplay.h"

#define QP_BF_TIMESCORE @"TimeScore"
#define QP_BF_ACCSCORE @"AccScore"
#define QP_BF_PATHSCORE @"PathScore"
#define QP_BF_SCORE @"Score"

@interface QPBFScoreState : QPBFState <ScoreDisplayDelegate> {
    
}

@property (strong, nonatomic) ScoreDisplay *scoreDisplay;

@end
