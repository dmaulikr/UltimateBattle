//
//  RecycleDisplay.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "RecycleDisplay.h"

@implementation RecycleDisplay

- (void)initializeLabels {
    [super initializeLabels];
        CGSize size = CGSizeMake(80, 40);
    self.debrisLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
    [self addChild:self.debrisLabel];
}

- (void)drawLabels {
    [super drawLabels];
    
    self.debrisLabel.position    = ccp([self center].x, [self center].y - 35    );
    [self.debrisLabel setString:[NSString stringWithFormat:@"%d", _debris]];
    [self.debrisLabel updateTexture];
}

- (float)labelDistance {
    return [self baseLabelDistance];
}

- (void)pulse {
    
}

- (void)drawText {
    //draw circle
    self.timeLabel.string       = @"O";
    self.accuracyLabel.string   = _weapon;
    //draw !
    self.pathingLabel.string    = @"!";
    //draw redline
    self.scoreLabel.string      = @"--";
}

- (void)showWeapon:(NSString *)w {
    _weapon = w;
    [self drawText];
}

- (void)reloadDebrisLabel:(int)d {
    _debris = d;
    [self drawLabels];
}

@end
