//
//  WeaponsLabel.m
//  QuantumPilot
//
//  Created by quantum on 04/01/2015.
//
//

#import "WeaponsLabel.h"

@implementation WeaponsLabel

- (int)maximumBonusFont {
    return 19;
}

- (int)bonusFontIncrease {
    return 1;
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimation) name:@"WeaponPulse" object:nil];
}

@end
