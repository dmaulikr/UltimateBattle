//
//  AccuracyLabel.m
//  QuantumPilot
//
//  Created by quantum on 03/01/2015.
//
//

#import "AccuracyLabel.h"

@implementation AccuracyLabel

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation) name:@"AccuracyPulse" object:nil];
}

@end
