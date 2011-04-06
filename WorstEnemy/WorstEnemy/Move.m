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
    CGFloat distance = ccpDistance(self.fromPoint, self.toPoint);
    
    CGPoint adjustPoint = ccpSub(self.toPoint, self.fromPoint);
    adjustPoint = ccp(-adjustPoint.x, adjustPoint.y);
    
    CGPoint moveToPoint = ccp(self.fromPoint.x + adjustPoint.x - PLAYER_ENEMY_DISTANCE, self.toPoint.y);
    
    return [CCMoveTo actionWithDuration:(distance/THRUST) position:moveToPoint];
}

//-(CCMoveBy *) createEnemyMove {
//    CGPoint moveByPoint = ccpSub(self.toPoint, self.fromPoint);
//    moveByPoint = ccp(-moveByPoint.x, moveByPoint.y);
//    NSLog(@"start time %f - end time %f", self.startTime, self.endTime);
//    ccTime duration = self.endTime - self.startTime;
//    return [CCMoveBy actionWithDuration:duration position:moveByPoint];
//}

@end
