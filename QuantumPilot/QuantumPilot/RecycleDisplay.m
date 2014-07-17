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
    self.accuracyLabel.string   = @"TRIPLE";
    self.pathingLabel.string    = @"WARNING";
    self.scoreLabel.string      = @"BOMB";
}

@end
