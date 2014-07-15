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
        
        CGSize size = CGSizeMake(80, 40);
        
        self.timeLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
        self.accuracyLabel = [CCLabelTTF labelWithString:nil  dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
        self.pathingLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
        self.scoreLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
        
        [self addChild:self.timeLabel];
        [self addChild:self.accuracyLabel];
        [self addChild:self.pathingLabel];
        [self addChild:self.scoreLabel];
        
        vertexes[0] = ccp(5000, 5000);
        vertexes[1] = ccp(5000, 5000);
        vertexes[2] = ccp(5000, 5000);
        vertexes[3] = ccp(5000, 5000);
    
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
    
    float halfSegment = distance;
    self.timeLabel.position     = ccp(l.x - halfSegment, l.y + halfSegment);
    self.accuracyLabel.position = ccp(l.x + halfSegment, l.y + halfSegment);
    self.pathingLabel.position  = ccp(l.x - halfSegment, l.y - halfSegment);
    self.scoreLabel.position    = ccp(l.x + halfSegment, l.y - halfSegment);
    
    self.timeLabel.string       = [NSString stringWithFormat:@"TIME\n%d", time];
    self.accuracyLabel.string   = [NSString stringWithFormat:@"ACCURACY\n%d", accuracy];
    self.pathingLabel.string    = [NSString stringWithFormat:@"PATHING\n%d", pathing];
    self.scoreLabel.string      = [NSString stringWithFormat:@"SCORE\n%d", score];
    
    [self.timeLabel updateTexture];
    [self.accuracyLabel updateTexture];
    [self.pathingLabel updateTexture];
    [self.scoreLabel updateTexture];
}

- (int)iteration {
    return iteration;
}

@end
