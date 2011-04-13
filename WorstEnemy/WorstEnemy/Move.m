//
//  Move.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/25/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "Move.h"


@implementation Move

@synthesize toPoint;
@synthesize fromPoint;
@synthesize startTime;
@synthesize endTime;

#define THRUST 100
#define PLAYER_ENEMY_DISTANCE 300

-(id) initWithFromPoint:(CGPoint) fromP withStartTime:(ccTime) sTime {
    self = [super init];
    if (self) {
        self.fromPoint = fromP;
        self.startTime = sTime;
    }
    return self;    
}

-(void) endMoveWithToPoint:(CGPoint) toP withEndTime:(ccTime) eTime {
    self.toPoint = toP;
    self.endTime = eTime;
}

-(CCMoveTo *) createEnemyMove {
    CGPoint adjustPoint = ccpSub(self.toPoint, self.fromPoint);
    adjustPoint = ccp(-adjustPoint.x, adjustPoint.y);
    
    float duration = self.endTime - self.startTime;
    return [CCMoveBy actionWithDuration:duration position:adjustPoint];
}


@end
