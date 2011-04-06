//
//  Move.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/25/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Move : NSObject {
    
}

@property (nonatomic) CGPoint fromPoint;
@property (nonatomic) CGPoint toPoint;
@property (nonatomic) ccTime startTime;
@property (nonatomic) ccTime endTime;

-(id) initWithFromPoint:(CGPoint) fromP withStartTime:(ccTime) sTime;

-(void) endMoveWithToPoint:(CGPoint) toP withEndTime:(ccTime) eTime;
-(CCMoveTo *) createEnemyMove;

@end
