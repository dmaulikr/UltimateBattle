//
//  PathsLabel.m
//  QuantumPilot
//
//  Created by quantum on 04/01/2015.
//
//

#import "PathsLabel.h"

@implementation PathsLabel

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation) name:@"PathsPulse" object:nil];
}

- (void)resetAnimation {
    [super resetAnimation];
    self.alpha = 1;
}


@end
