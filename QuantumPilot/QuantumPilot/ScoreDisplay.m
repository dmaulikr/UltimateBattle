//
//  ScoreDisplay.m
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "ScoreDisplay.h"

@implementation ScoreDisplay

- (id)initWithTimeScore:(int)t accuracyScore:(int)a pathingScore:(int)p currentScore:(int)s {
    self = [super init];
    if (self) {
        iteration = 30;
        
        time = t;
        accuracy = a;
        pathing = p;
        score = s;
        
        self.totalScoreIncrease = time + accuracy + pathing;
        
        NSLog(@"display opening score: %d", score);

        pathingPerfect = pathing == 100000;
        accuracyPerfect = accuracy == 100000;
        timePerfect = time == 5780;
        
    }
    return self;
}

- (void)scorePoints {
    if (time > 0) {
        if (time > 99) {
            time-= 99;
            score += 99;
        } else {
            time--;
            score++;
        }
    }
    
    if (accuracy > 0) {
        if (accuracy > 999) {
            accuracy-= 999;
            score+=999;
        } else if (accuracy > 99) {
            accuracy-= 99;
            score+= 99;
        } else {
            accuracy--;
            score++;
        }
    }
    
    if (pathing > 0) {
        if (pathing > 999) {
            pathing-= 999;
            score+=999;
        } else if (pathing > 99) {
            pathing-= 99;
            score+= 99;
        } else {
            pathing--;
            score++;
        }
    }
    
    if (time <= 0 && accuracy <= 0 && pathing <= 0) {
        iteration = 50;
        state = displayResting;
    }
}

- (void)pulse {
    [super pulse];
    if (state == displayZooming) {
        iteration--;
        if (iteration == 0) {
            state = displayCalculating;
            iteration = 150;
        }
    } else if (state == displayCalculating){
        if (iteration > 0) {
            iteration--;
        } else {
            [self scorePoints];
        }
    } else {
        iteration--;
        if (iteration <= 0) {
            [self.delegate finishedDisplayingWithTotalScore:score];
        }
    }
}

- (float)labelDistance {
    float distance = [self baseLabelDistance];
    if (state == displayZooming) {
        distance = 50 + (iteration * 15);
    }
    return distance;
}

- (NSString *)timeText {
    return timePerfect ? @"TIME\nFULL" : [NSString stringWithFormat:@"TIME\n%d", time];
}

- (NSString *)accuracyText {
    return accuracyPerfect ? @"ACCURACY\nABSOLUTE" : [NSString stringWithFormat:@"ACCURACY\n%d", accuracy];
}

- (NSString *)pathingText {
    return pathingPerfect ? @"PATHING\nPERFECT" : [NSString stringWithFormat:@"PATHING\n%d", pathing];
}

- (NSString *)scoreText {
    return [NSString stringWithFormat:@"SCORE\n%d", score];
}

- (int)iteration {
    return iteration;
}

@end
