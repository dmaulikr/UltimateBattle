//
//  ScoreLabel.m
//  QuantumPilot
//
//  Created by quantum on 03/01/2015.
//
//

#import "ScoreLabel.h"

@implementation ScoreLabel

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation:) name:@"ScorePulse" object:nil];
}


@end
