//
//  Ship.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "Ship.h"


#define THRUST 100

@implementation Ship

@synthesize weapon;
@synthesize currentMove;
@synthesize sprite;
@synthesize startPoint;
@synthesize moves;
@synthesize engine_flare;
@synthesize totalTime;

# define SHIP_SIZE 30
# define HALF_SHIP_SIZE 15

-(id) initWithLocation:(CGPoint) point {
    self = [super init];
    if (self) {
        self.startPoint = point;
        self.weapon = [[Weapon alloc] init];
        self.moves = [NSMutableArray array];
        self.totalTime = 0;
        
        self.sprite = [CCSprite spriteWithFile:@"your_ship.png" rect:CGRectMake(0, 0, 60, 60)];
        self.sprite.scale = .5;
        self.sprite.position = point;
        [self createEngineFlare];
    }
    return self;
}

-(CGPoint) engineFlarePoint:(CGPoint) point {
    return ccp(point.x +15, point.y);
}

-(void) createEngineFlare {
    self.engine_flare = [[CCParticleFire alloc] initWithTotalParticles:7000];
    [self.engine_flare setPosition:[self engineFlarePoint:self.sprite.position]];
    [self.engine_flare setAngle:0.0];
    [self.engine_flare setAngleVar:30.0];
    [self.engine_flare setStartSize:2.0];
    [self.engine_flare setPosVar:ccp(0,4)];
    [self.engine_flare setEndSize:0.01];
    [self.engine_flare setLife:5.2];
    [self.engine_flare setLifeVar:0.1];
    [self.engine_flare setSpeed: 200];
    [self.engine_flare setSourcePosition:ccp(0,0)];
    [self.engine_flare setTexture:nil];
}

-(void) addToLayer:(CCLayer *) layer {
    [layer addChild:self.sprite];
    [layer addChild:self.engine_flare z:-1];
}

-(void) addTime:(ccTime) time {
    self.totalTime += time;
}

-(void) moveTo:(CGPoint) point {
    if (self.currentMove) {
        [self endCurrentMove];
    }
    CGFloat distance = ccpDistance(self.sprite.position, point);
    CCMoveTo *moveTo = [CCMoveTo actionWithDuration:(distance/THRUST) position:point];
    CCCallFunc *endMove = [CCCallFunc actionWithTarget:self selector:@selector(endCurrentMove)];
    [self.sprite runAction:[CCSequence actionOne:moveTo two:endMove]];
    
    CCMoveTo *engineMoveTo = [CCMoveTo actionWithDuration:(distance/THRUST) position:[self engineFlarePoint:point]];
    [self.engine_flare runAction:engineMoveTo];
    self.currentMove = [[[Move alloc] initWithFromPoint:self.sprite.position withStartTime:self.totalTime] autorelease];
}

-(NSArray *) fire {
    return [self.weapon getBullets:CGPointMake(50,50)];//self.sprite.position];
}

-(CGRect) getRect {
    return CGRectMake(self.sprite.position.x - HALF_SHIP_SIZE, 
                      self.sprite.position.y - HALF_SHIP_SIZE, 
                      SHIP_SIZE, 
                      SHIP_SIZE);
}

-(void) endCurrentMove {
    if (self.currentMove) {
        [self.currentMove endMoveWithToPoint:self.sprite.position withEndTime:self.totalTime];
		self.totalTime = 0;
		
        [self.moves addObject:self.currentMove];
        self.currentMove = nil;
    }
}

-(void) reset {
    [self.sprite stopAllActions];
    [self.engine_flare stopAllActions];
    self.sprite.position = self.startPoint;
    [self.engine_flare setPosition:[self engineFlarePoint:self.startPoint]];
    self.moves = [NSMutableArray array];
}

@end
