//
//  ScoreDisplay.m
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "ScoreDisplay.h"
#import "QuantumPilot.h"

@implementation ScoreDisplay

- (id)initWithTimeScore:(int)t accuracyScore:(int)a pathingScore:(int)p currentScore:(int)s {
    self = [super init];
    if (self) {
        iteration = 30;
        l = [QuantumPilot resetPosition];
        
        time = t;
        accuracy = a;
        pathing = p;
        score = s;
        NSLog(@"display opening score: %d", score);
    
    }
    return self;
}

- (void)pulse {
    if (state == displayZooming) {
        iteration--;
        if (iteration == 0) {
            state = displayCalculating;
        }
    } else if (state == displayCalculating){
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
            if (accuracy > 9999) {
                accuracy-= 9999;
                score+= 9999;
            } else if (accuracy > 999) {
                accuracy-= 999;
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
        
        if (time <=0 && accuracy <= 0) {
            iteration = 50;
            state = displayResting;
        }
    } else {
        iteration--;
        if (iteration <= 0) {
            [self.delegate finishedDisplayingWithTotalScore:score];
        }
    }
}

- (void)draw {
    float distance = 50;
    if (state == displayZooming) {
        distance = 50 + (iteration * 15);
    }
    vertexes[0] = ccp(l.x - distance, l.y);
    vertexes[1] = ccp(l.x, l.y + distance);
    vertexes[2] = ccp(l.x + distance, l.y);
    vertexes[3] = ccp(l.x, l.y - distance);
    
    ccDrawColor4F(1, 1, 1, 1.0);
    
    ccDrawPoly(vertexes, 4, true);
    
    
}

- (int)iteration {
    return iteration;
}


@end
