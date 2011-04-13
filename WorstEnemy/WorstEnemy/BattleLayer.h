//
//  HelloWorldLayer.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright Pursuit 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Ship.h"
#import "cmpgames.h"
#import "Bullet.h"
#import "EnemyShip.h"
#import "KillerBar.h"
#import "Move.h"

// HelloWorldLayer
@interface BattleLayer : CCLayer
{
    
}

@property (nonatomic, retain) Ship *ship;
@property (nonatomic, retain) KillerBar *killerBar;
@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, retain) NSMutableArray *enemyBullets;
@property (nonatomic, retain) NSMutableArray *enemies;
@property (nonatomic, retain) NSMutableArray *pastLives;
@property (nonatomic) int kill_count;
@property (nonatomic) int newLevelDelay;
@property (nonatomic) bool isMovingToNextLevel;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(BOOL) enemiesAreAllDead;
-(void) newLevel;
-(void) createFirstEnemy;

@end
