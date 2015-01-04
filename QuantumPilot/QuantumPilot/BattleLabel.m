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

- (bool)maxFont {
    return bonusFont > 12;
}



- (void)processMaxFont {
    timer = -1;
    bonusFont = 0;
}

- (void)pulse {
    if (timer > 0) {
        timer--;
        if (timer <= 0) {
            [self resetTimer];
            bonusFont++;
        
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

@end
