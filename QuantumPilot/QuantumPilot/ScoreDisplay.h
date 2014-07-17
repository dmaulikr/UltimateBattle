//
//  ScoreDisplay.h
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "cocos2d.h"
#import "QPBFDisplay.h"

enum displaystate {
    displayZooming = 0,
    displayCalculating,
    displayResting
};


@interface ScoreDisplay : QPBFDisplay {
    int iteration;
    
    int state;
    
    int time;
    int accuracy;
    int pathing;
    int score;
    
    bool timePerfect;
    bool accuracyPerfect;
    bool pathingPerfect;
}

- (int)iteration;


- (id)initWithTimeScore:(int)t accuracyScore:(int)a pathingScore:(int)p currentScore:(int)s;


@end
