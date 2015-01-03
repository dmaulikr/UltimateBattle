//
//  BattleLabel.m
//  QuantumPilot
//
//  Created by quantum on 03/01/2015.
//
//

#import "BattleLabel.h"

@implementation BattleLabel

- (id)initWithFrame:(CGRect)frame size:(int)fontSize {
    self = [super initWithFrame:frame];
    [self resetAnimation];
    defaultSize = fontSize ?: 12;
    return self;
}

- (void)resetTimer {
    timer = 5;
}

- (bool)maxFont {
    return bonusFont > 20;
}

- (void)pulse {
    if (timer > 0) {
        timer--;
        if (timer < 0) {
            [self resetTimer];
            bonusFont++;
            if ([self maxFont]) {
                timer = -1;
                bonusFont = 0;
            }
            [self updateFont];
        }
    } else {
            
    }
}

- (void)updateFont {
    self.font = [UIFont systemFontOfSize:defaultSize + bonusFont];
}

- (void)resetAnimation {
    bonusFont = 0;
    [self resetTimer];
}

@end
