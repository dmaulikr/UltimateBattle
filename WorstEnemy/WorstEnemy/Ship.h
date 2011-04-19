//
//  Ship.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cmpgames.h"
#import "Weapon.h"
#import "cocos2d.h"
#import "Move.h"
#import "Engine.h"

@interface Ship : NSObject {
    
}

@property (nonatomic) CGPoint startPoint;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, retain) Move *currentMove;
@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, retain) id engine_flare;
@property (nonatomic) ccTime totalTime;

-(id) initWithLocation:(CGPoint) point;
-(void) addTime:(ccTime) time;
-(void) moveTo:(CGPoint) point;
-(void) addToLayer:(CCLayer *) layer;
-(NSArray *) fire;
-(void) createEngineFlare;
-(void) reset;
-(void) endCurrentMove;
-(CGRect) getRect;

@end
