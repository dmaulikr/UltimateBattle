//
//  LaserButton.m
//  QuantumPilot
//
//  Created by quantum on 29/01/2015.
//
//

#import "LaserButton.h"
#import "QPBattlefield.h"

@implementation LaserButton

- (void)styleLabel {
    self.label.textColor = [UIColor redColor];
}

- (NSString *)updateNotificationName {
    return @"LaserLabel";
}

- (void)upgrade {
    [[QPBattlefield f] upgradeLaser:self];
}


@end
