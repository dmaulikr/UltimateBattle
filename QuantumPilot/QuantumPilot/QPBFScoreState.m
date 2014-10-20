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

- (void)interruptedTransition:(CGPoint)l {
    ScoreDisplay *sd = (ScoreDisplay *)self.scoreDisplay;
    [self finishedDisplayingWithTotalScore:[sd totalScoreIncrease] + self.f.score];
    [self deactivate];
    [self.f finishedDisplayingScore:l rush:true];
}

- (void)addTouch:(CGPoint)l {
    [self.f setTouchOffsetFromPilotNear:l];
    [self interruptedTransition:l];
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
    [self.f finishedDisplayingScore:self.f.pilot.l rush:false];
    NSLog(@"score: %d", self.f.score);
}

- (void)dealloc {
    [self.scoreDisplay removeFromParentAndCleanup:true];
    self.scoreDisplay = nil;
    [super dealloc];
}

@end
