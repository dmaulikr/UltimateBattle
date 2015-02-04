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
    [self resetAnimation:nil];
    [self setupNotifications];
    defaultSize = fontSize ?: 16;
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

- (NSString *)nameOfFont {
    return @"Courier";
}

- (void)updateFont {
    self.font = [UIFont fontWithName:[self nameOfFont] size:defaultSize + bonusFont];
}

- (void)resetAnimation:(NSNotification *)n {
    bonusFont = 0;
    if (n.object) {
        timer = -1;
        [self updateFont];
        return;
    }

    bonusFont = 0;
    [self resetTimer];
}

- (void)cancel {
    bonusFont = 20;
    timer = -1;
    [self updateFont];
}

- (void)displayText {
    
}

@end
