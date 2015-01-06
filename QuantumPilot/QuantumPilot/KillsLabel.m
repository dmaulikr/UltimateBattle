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

- (void)resetAnimation:(NSNotification *)n {
    [super resetAnimation:n];
    self.alpha = 1;
    consecutive++;
}

- (void)processMaxFont {
    [super processMaxFont];
    self.alpha = 0;
    consecutive = 0;
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation:) name:@"KillsPulse" object:nil];
}

- (void)displayText {
    self.text = [@"" stringByPaddingToLength:consecutive + 1 withString:@"¤"startingAtIndex:0];
}

@end
