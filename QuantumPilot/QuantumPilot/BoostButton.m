//
//  BoostButton.m
//  QuantumPilot
//
//  Created by quantum on 22/01/2015.
//
//

#import "BoostButton.h"
#import "QPBattlefield.h"

@implementation BoostButton

- (void)styleLabel {
    self.label.textColor = [UIColor greenColor];
}

- (NSString *)updateNotificationName {
    return @"BoostLabel";
}

- (void)upgrade {
    [[QPBattlefield f] upgradeBoost:self];
}

@end
