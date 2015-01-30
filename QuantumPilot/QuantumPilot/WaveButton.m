//
//  WaveButton.m
//  QuantumPilot
//
//  Created by quantum on 29/01/2015.
//
//

#import "WaveButton.h"

@implementation WaveButton

- (void)styleLabel {
    self.label.textColor = [UIColor yellowColor];
    self.userInteractionEnabled = false;
}

- (NSString *)updateNotificationName {
    return @"WaveLabel";
}

@end
