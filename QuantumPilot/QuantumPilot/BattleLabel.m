//
//  BattleLabel.m
//  QuantumPilot
//
//  Created by quantum on 03/01/2015.
//
//

#import "BattleLabel.h"

@implementation BattleLabel

- (void)setupNotifications {
    
}

- (id)initWithFrame:(CGRect)frame size:(int)fontSize {
    self = [super initWithFrame:frame];
    [self resetAnimation];
    [self setupNotifications];
    defaultSize = fontSize ?: 12;
    return self;
}

- (void)resetTimer {
    timer = 1;
}

- (int)maximumBonusFont {
    return 24;
}

- (bool)maxFont {
    return bonusFont > [self maximumBonusFont];
}



- (void)processMaxFont {
    timer = -1;
    bonusFont = 0;
}

- (int)bonusFontIncrease {
    return 1;
}

- (void)increaseBonusFont {
    bonusFont+= [self bonusFontIncrease];
}

- (void)pulse {
    if (timer > 0) {
        timer--;
        if (timer <= 0) {
            [self resetTimer];
            [self increaseBonusFont];
        
            if ([self maxFont]) {
                [self processMaxFont];
            }
            [self updateFont];
        }
    }
}

- (void)updateFont {
    self.font = [UIFont systemFontOfSize:defaultSize + bonusFont];
}

- (void)resetAnimation {
    bonusFont = 0;
    [self resetTimer];
}

- (void)cancel {
    bonusFont = 0;
    timer = -1;
    [self updateFont];
}

@end
