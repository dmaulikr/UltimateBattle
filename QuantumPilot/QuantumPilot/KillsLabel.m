//
//  KillsLabel.m
//  QuantumPilot
//
//  Created by quantum on 04/01/2015.
//
//

#import "KillsLabel.h"

@implementation KillsLabel

- (int)maximumBonusFont {
    return 54;
}

- (int)bonusFontIncrease {
    return 2;
}

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
