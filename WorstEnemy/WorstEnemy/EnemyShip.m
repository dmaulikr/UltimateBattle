//
//  EnemyShip.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/24/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "EnemyShip.h"
#import "Move.h"


@implementation EnemyShip

@synthesize sprite;
@synthesize isDead;
@synthesize moveSequence;
@synthesize startPoint;

# define SHIP_SIZE 45
# define HALF_SHIP_SIZE 22.5

-(id) initWithMoves:(NSMutableArray *)shipMoves atStartPoint:(CGPoint) point {
    self = [super init];
    if (self) {
        
        [self createMoveSequenceFromShipMoves:shipMoves];
        self.isDead = false;
        self.startPoint = point;
        
        sprite = [[CCSprite alloc] initWithFile:@"enemy_ship.png" rect:CGRectMake(0, 0, SHIP_SIZE, SHIP_SIZE)];
        sprite.scale = .5;
        [sprite setPosition:startPoint];
    }
    return self;
}
-(void) createMoveSequenceFromShipMoves:(NSMutableArray *) shipMoves {
    if (shipMoves.count == 0) {
        return;
    }
    
    NSMutableArray *ccActions = [NSMutableArray array];
    Move *firstMove = (Move *)[shipMoves objectAtIndex:0];
    ccTime current = firstMove.startTime;
    for(Move *move in shipMoves) {
        if (current != move.startTime) {
            [ccActions addObject:[CCDelayTime actionWithDuration:0.3]];
//            [ccActions addObject:[CCDelayTime actionWithDuration:(move.startTime - current)]];
            //[ccActions addObject:[CCMoveBy actionWithDuration:(move.startTime - current) position:ccp(0,0)]];
        }
        [ccActions addObject:[move createEnemyMove]];
        current = move.endTime;
    }
    
    if (ccActions.count > 0) {
        CCCallFunc *reset = [CCCallFunc actionWithTarget:self selector:@selector(reset)];
        [ccActions addObject:reset];
        NSLog(@"move sequence");
        self.moveSequence = [EnemyShip getActionSequence:ccActions];
    }    
}

-(void) reset {
    self.sprite.position = self.startPoint;
}

-(void) addToLayer:(CCLayer *)layer {
    [layer addChild:self.sprite];
    if (self.moveSequence) {
        CCRepeatForever *moveLoop = [CCRepeatForever actionWithAction:self.moveSequence];
        [self.sprite runAction:moveLoop];
    }
}

-(CGRect) getRect {
    return CGRectMake(self.sprite.position.x - HALF_SHIP_SIZE, 
               self.sprite.position.y - HALF_SHIP_SIZE, 
               SHIP_SIZE, 
                      SHIP_SIZE);
}

-(void) removeFromLayer:(CCLayer *)layer {
    [layer removeChild:self.sprite cleanup:NO];
}

-(void) kill {
    self.isDead = true;
}

-(void) revive {
    self.isDead = false;
}

+(CCFiniteTimeAction *) getActionSequence: (NSArray *) actions
{
	CCFiniteTimeAction *seq = nil;
	for (CCFiniteTimeAction *anAction in actions)
	{
		if (!seq) {
			seq = anAction;
		}
		else {
			seq = [CCSequence actionOne:seq two:anAction];
		}
	}
	return seq;
}

@end
