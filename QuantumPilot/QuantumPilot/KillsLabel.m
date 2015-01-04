//
//  KillsLabel.m
//  QuantumPilot
//
//  Created by quantum on 04/01/2015.
//
//

#import "KillsLabel.h"

@implementation KillsLabel

- (void)resetAnimation {
    [super resetAnimation];
    self.alpha = 1;
}

- (void)processMaxFont {
    [super processMaxFont];
    self.alpha = 0;
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation) name:@"KillsPulse" object:nil];
}

@end
