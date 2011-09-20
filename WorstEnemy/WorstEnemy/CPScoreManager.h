//
//  CPScoreManager.h
//  WorstEnemy
//
//  Created by Anthony Broussard on 9/20/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>

//combo kills
//accuracy in shots fired
//accuracy center of ship hit (dead center / dead on / perfect shot)
//time elapsed
//perfect bonus (no hit)
//health multiplier bonus


@interface CPScoreManager : NSObject {
    int comboTimerLeft;
    int comboScore;
    int comboTotal;
    int comboTimerReset;
    int shotsFired;
    float killScore;
    int healthScore;
    int timeScore;
    int timeLeft;
}

- (void)update;
- (void)scoreKill:(float)accuracy;
- (void)allClear;
- (void)shotFired;



@end
