//
//  QPBFScoreState.m
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "QPBFScoreState.h"
#import "QPBattlefield.h"

@implementation QPBFScoreState

- (void)pulse {
    [self.scoreDisplay pulse];
}

- (void)activate:(NSDictionary *)options {
    self.scoreDisplay = [[[ScoreDisplay alloc] initWithTimeScore:[options[QP_BF_TIMESCORE] intValue] accuracyScore:[options[QP_BF_ACCSCORE] intValue] pathingScore:[options[QP_BF_PATHSCORE] intValue] currentScore:[options[QP_BF_SCORE]intValue]] autorelease];
    self.scoreDisplay.delegate = self;
    [self.f addChild:self.scoreDisplay];
}

- (void)deactivate {
    [self.f removeChild:self.scoreDisplay cleanup:true];
    self.scoreDisplay = nil;
}

#pragma mark ScoreDisplayDelegaet

- (void)finishedDisplayingWithTotalScore:(int)score {
    self.f.score = score;
    [self.f changeState:self.f.pausedState];
    NSLog(@"score: %d", self.f.score);
}

@end
