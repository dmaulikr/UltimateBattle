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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation:) name:@"PathsPulse" object:nil];
}

- (void)resetAnimation:(NSNotification *)n {
    [super resetAnimation:n];
    self.alpha = 1;
}

- (void)displayText {
    self.text = @"ζ";
    self.alpha = 1;
}

- (void)processMaxFont {
    self.alpha = 0;
    timer = -1;
    bonusFont = 0;
}

@end
