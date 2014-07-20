//
//  RecycleDisplay.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "RecycleDisplay.h"

@implementation RecycleDisplay

- (float)labelDistance {
    return [self baseLabelDistance];
}

- (void)pulse {
    
}

- (void)drawText {
    self.timeLabel.string       = @"SHIELD";
    self.accuracyLabel.string   = _weapon;
    self.pathingLabel.string    = @"WARNING";
    self.scoreLabel.string      = @"BOMB";
}

- (void)showWeapon:(NSString *)w {
    _weapon = w;
    [self drawText];
}

@end
