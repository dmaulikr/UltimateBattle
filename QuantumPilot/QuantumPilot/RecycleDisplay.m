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

//- (void)drawLabels {
//    [super drawLabels];
//    
//    self.debrisLabel.position    = ccp([self center].x, [self center].y - 35    );
//    if (_debris <= 99) {
//        [self.debrisLabel setString:[NSString stringWithFormat:@"%d", _debris]];
//    } else {
//        self.debrisLabel.string = @"+";
//    }
//    [self.debrisLabel updateTexture];
//}

- (NSString *)timeText {
    return [[QPBattlefield f] shieldMaxed] ? @"GUARD\nMAX" : [NSString stringWithFormat:@"%d",[[QPBattlefield f] shieldCost]];
}

- (NSString *)accuracyText {
    if ([_weapon isEqualToString:@"GOOD LUCK!"]) {
        return [NSString stringWithFormat:@"GOOD\nLUCK"];
    }
    
    [NSClassFromString(_weapon) setDrawColor];
    return [NSString stringWithFormat:@"%d", _weaponCost];
}

- (NSString *)pathingText {
    return warning ? @"WARNING\nON" : [NSString stringWithFormat:@"%d",[[QPBattlefield f] warningCost]];
}

- (NSString *)scoreText {
    return slow ? @"MORE\nTIME" : [NSString stringWithFormat:@"%d", [[QPBattlefield f] slowCost]];
}

- (CGPoint)timePosition {
    float h = 578;
    return ccp(l.x - [self labelDistance], h - (l.y + [self labelDistance]));
}

- (CGPoint)accuracyPosition {
    float h = 578;
    return ccp(l.x + [self labelDistance], h - (l.y + [self labelDistance]));
}

- (CGPoint)pathingPosition {
    float h = 578;
    return ccp(l.x - [self labelDistance], h - (l.y - [self labelDistance]));
}

- (CGPoint)scorePosition {
    float h = 578;
    return ccp(l.x + [self labelDistance], h - (l.y - [self labelDistance]));
}

- (float)labelDistance {
    return [self baseLabelDistance] * 1;
}

- (void)drawWeaponLabel {
    float halfSegment = [self labelDistance];
    float mod = 7;
    if ([_weapon isEqualToString:@"GOOD LUCK!"]) {
    } else {
        [NSClassFromString(_weapon) setDrawColor];
        ccDrawFilledCircle(ccp(l.x + halfSegment, l.y + halfSegment + mod) , 2.6, 0, 100, NO);
    }
}

- (void)drawText {
    float halfSegment = [self labelDistance];
    float mod = 7;
    
    [self drawWeaponLabel];
    
    if (!slow) {
        ccDrawColor4F(1, 0, 0, 1.0);
        ccDrawLine(ccp(l.x + halfSegment - 5, l.y - halfSegment + mod + 9), ccp(l.x + halfSegment + 5, l.y - halfSegment + mod + 9));
    }

    if (![[QPBattlefield f] shieldMaxed]) {
        ccDrawColor4F(1, 1, 1, 1);
        ccDrawCircle(ccp(l.x - halfSegment, l.y + halfSegment + mod), 3, 0, 100, NO);
    }
    
    if (!warning) {
        CGPoint bangTop = ccp(l.x - halfSegment, l.y - halfSegment + 25);
        CGPoint bangBottom = ccp(l.x - halfSegment, l.y - halfSegment + 18);
        
        ccDrawLine(bangTop, bangBottom);
        ccDrawFilledCircle(ccp(bangBottom.x, bangBottom.y - 6), 1, 0, 100, NO);
    }
}

- (void)showWeapon:(NSString *)w {
    _weapon = w;
    _weaponCost = -1;
    [self drawText];
}

- (void)draw {
    [super draw];
//    [self drawLabels];
    [self drawText];
}

- (void)showWeapon:(NSString *)w cost:(int)cost {
    [self showWeapon:w];
    _weaponCost = cost;
}

- (void)showWarningActivated:(bool)w {
    warning = w;
}

- (void)showSlow:(bool)s {
    slow = s;
}

- (void)reloadDebrisLabel:(int)d {
    _debris = d;
    [self drawLabels];
}

- (void)dealloc {
    _weapon = nil;
    [self.debrisLabel removeFromParentAndCleanup:true];
    self.debrisLabel = nil;
    [super dealloc];
}

@end
