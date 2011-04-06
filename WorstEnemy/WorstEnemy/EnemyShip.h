//
//  EnemyShip.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/24/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cmpgames.h"
#import "Weapon.h"
#import "cocos2d.h"

@interface EnemyShip : NSObject {
    
}

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic) BOOL isDead;
@property (nonatomic, retain) CCFiniteTimeAction *moveSequence;
@property (nonatomic) CGPoint startPoint;

-(id) initWithMoves:(NSMutableArray *) moves atStartPoint:(CGPoint) startPoint; 

-(void) createMoveSequenceFromShipMoves:(NSMutableArray *) shipMoves;

-(void) addToLayer:(CCLayer *) layer;
-(void) removeFromLayer:(CCLayer *) layer;

-(void) kill;
-(void) revive;
-(void) reset;

-(CGRect) getRect;

+(CCFiniteTimeAction *) getActionSequence: (NSArray *) actions;

@end
