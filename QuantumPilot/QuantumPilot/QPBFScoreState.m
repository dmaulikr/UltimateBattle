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
    if (self.scoreDisplay.iteration > 0) {
        [self.scoreDisplay pulse];
    } else {
        //change score display state to iterate
    //    [self.f changeState:self.f.pausedState];
    }
}

- (void)activate {
    self.scoreDisplay = [[[ScoreDisplay alloc] init] autorelease];
    [self.f addChild:self.scoreDisplay];
}

- (void)deactivate {
    [self.f removeChild:self.scoreDisplay cleanup:true];
    self.scoreDisplay = nil;
}

@end
