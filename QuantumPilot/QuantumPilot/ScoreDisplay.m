//
//  ScoreDisplay.m
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "ScoreDisplay.h"
#import "cocos2d.h"
#import "QuantumPilot.h"

@implementation ScoreDisplay

- (id)init {
    self = [super init];
    if (self) {
        iteration = 30;
        l = [QuantumPilot resetPosition];
    }
    return self;
}

- (void)pulse {
    iteration--;
}

- (void)draw {
    float distance = 50 + (iteration * 15);
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
