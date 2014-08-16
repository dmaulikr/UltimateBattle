//
//  RecycleDisplay.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "RecycleDisplay.h"
#import "Weapon.h"
#import "QPBattlefield.h"

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
    if (_debris <= 9) {
        [self.debrisLabel setString:[NSString stringWithFormat:@"%d", _debris]];
    } else {
        self.debrisLabel.string = @"+";
    }
    [self.debrisLabel updateTexture];
    
    float halfSegment = [self labelDistance];
    self.timeLabel.position     = ccp(l.x - halfSegment, l.y + halfSegment - 20);
    self.accuracyLabel.position = ccp(l.x + halfSegment, l.y + halfSegment - 20);
    self.pathingLabel.position  = ccp(l.x - halfSegment, l.y - halfSegment - 15);
    self.scoreLabel.position    = ccp(l.x + halfSegment, l.y - halfSegment - 15);

}

//- (float)labelDistance {
//    return [self baseLabelDistance];
//}

- (void)pulse {
    
}

- (float)labelDistance {
    return [self baseLabelDistance] * .75;
}

- (void)drawText {
    float halfSegment = [self labelDistance];
    
    float mod = 7;
    
    NSLog(@"weapon: %@", _weapon);
    if ([_weapon isEqualToString:@"GOOD LUCK!"]) {
        self.accuracyLabel.string  = _weapon;
    } else {
        [NSClassFromString(_weapon) setDrawColor];
        ccDrawFilledCircle(ccp(l.x + halfSegment, l.y + halfSegment + mod) , 2.6, 0, 100, NO);
    }
    
    ccDrawColor4F(1, 0, 0, 1.0);
    ccDrawLine(ccp(l.x + halfSegment - 5, l.y - halfSegment + mod + 9), ccp(l.x + halfSegment + 5, l.y - halfSegment + mod + 9));

    ccDrawColor4F(1, 1, 0, 1);
    
    CGPoint bangTop = ccp(l.x - halfSegment, l.y - halfSegment + 25);
    CGPoint bangBottom = ccp(l.x - halfSegment, l.y - halfSegment + 18);
    
    ccDrawLine(bangTop, bangBottom);
    ccDrawFilledCircle(ccp(bangBottom.x, bangBottom.y - 6), 1, 0, 100, NO);
    
    ccDrawColor4F(1, 1, 1, 1);
    ccDrawCircle(ccp(l.x - halfSegment, l.y + halfSegment + mod), 3, 0, 100, NO);

    //draw pricing
    self.timeLabel.string = @"3";
    self.accuracyLabel.string = @"8";
    self.scoreLabel.string = @"5";
    self.pathingLabel.string = @"4";
    
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
