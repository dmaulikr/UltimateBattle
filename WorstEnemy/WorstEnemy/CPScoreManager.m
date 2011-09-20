//
//  CPScoreManager.m
//  WorstEnemy
//
//  Created by Anthony Broussard on 9/20/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "CPScoreManager.h"

@implementation CPScoreManager

- (void)calculateComboScore {
    comboScore+= comboTotal * comboTotal * 10;
}

- (void)update {
    if (comboTimerLeft > 0) {
        comboTimerLeft--;
        if (comboTimerLeft == 0) {
            [self calculateComboScore];
        }
    }
}

- (void)scoreCombo {
    comboTotal++;
    comboTimerLeft = comboTimerReset;
}

- (void)scoreKill:(float)accuracy {
    [self scoreCombo];
    killScore+= accuracy;
}

- (void)calculateTotalScores {
    healthScore = 0; //ship health ////self.ship.health * 10;
    timeScore = timeLeft * 10;
    if (0 == 1) {
        healthScore = healthScore * 2;
    }
    
}

- (void)allClear {
    [self calculateTotalScores];
}

- (void)shotFired {
    shotsFired++;
}

@end