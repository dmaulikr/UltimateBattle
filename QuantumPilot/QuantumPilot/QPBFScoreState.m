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

- (void)interruptedTransition {
    ScoreDisplay *sd = (ScoreDisplay *)self.scoreDisplay;
    [self finishedDisplayingWithTotalScore:[sd totalScoreIncrease] + self.f.score];
    [self deactivate];
    [self.f finishedDisplayingScore];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self interruptedTransition];
    } else {
        [self.f.pilot fire];
        [self.f setTouchOffsetFromPilotNear:self.f.pilot.l];
        [self.f addTouch:self.f.pilot.l];
        [self interruptedTransition];
    }
}

- (void)pulse {
    [self.scoreDisplay pulse];
}

- (Class)displayClass {
    return [ScoreDisplay class];
}

- (void)activate:(NSDictionary *)options {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearLabels" object:nil];
    NSLog(@"options: %@", options);
    self.scoreDisplay = [[[ScoreDisplay alloc] initWithTimeScore:[options[QP_BF_TIMESCORE] intValue] accuracyScore:[options[QP_BF_ACCSCORE] intValue] pathingScore:[options[QP_BF_PATHSCORE] intValue] currentScore:[options[QP_BF_SCORE]intValue]] autorelease];

    self.scoreDisplay.delegate = self;
    
   [self.f addChild:self.scoreDisplay]; //do this originally
}

- (void)deactivate {
    [self.scoreDisplay removeAllChildrenWithCleanup:true];
    [self.f removeChild:self.scoreDisplay cleanup:true];
    self.scoreDisplay = nil;
}

#pragma mark ScoreDisplayDelegate

- (void)finishedDisplayingWithTotalScore:(int)score {
    self.f.score = score;
    [self.f finishedDisplayingScore];
    NSLog(@"score: %d", self.f.score);
}

- (void)dealloc {
    [self.scoreDisplay removeFromParentAndCleanup:true];
    self.scoreDisplay = nil;
    [super dealloc];
}

@end
