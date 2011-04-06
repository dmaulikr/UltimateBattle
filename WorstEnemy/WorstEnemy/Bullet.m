//
//  Bullet.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

@synthesize sprite;
@synthesize trail;

#define BULLET_SIZE 15
#define HALF_BULLET_SIZE 7.5
#define BULLET_SPEED 300

-(id) initWithStart:(CGPoint) start withVelocity:(CGPoint) velocity {
    self = [super init];
    if (self) {
        self.sprite = [CCSprite spriteWithFile:@"bullet.png" rect:CGRectMake(0, 0, BULLET_SIZE, BULLET_SIZE)];
        self.sprite.position = start;
        
        [self createTrail];
    }
    return self;
}

-(void) createTrail {
    trail = [[CCParticleFire alloc] initWithTotalParticles:7000];
    [trail setStartColor:ccc4FFromccc3B(ccc3(0, 50, 250))]; 
    [trail setPosition:self.sprite.position];
    [trail setAngle:0.0];
    [trail setAngleVar:0.0];
    [trail setStartSize:0.3];
    [trail setPosVar:ccp(0,0)];
    [trail setEndSize:0.01];
    [trail setLife:0.03];
    [trail setLifeVar:0.05];
    [trail setSpeed: 200];
    [trail setSourcePosition:ccp(0,0)];
    [trail setTexture:nil];
}

-(void) addToLayer:(CCLayer *)layer {
    [layer addChild:self.sprite];
    [layer addChild:self.trail z:-1];
    
    CGPoint targetPoint = ccp(-10, self.sprite.position.y);
    CGFloat distance = ccpDistance(self.sprite.position, targetPoint);
    CCMoveTo *moveTo = [CCMoveTo actionWithDuration:(distance/BULLET_SPEED) position:targetPoint];
    [self.sprite runAction:moveTo];
    
    CCMoveTo *trailMoveTo = [CCMoveTo actionWithDuration:(distance/BULLET_SPEED) position:targetPoint];
    [self.trail runAction:trailMoveTo];
}

-(void) removeFromLayer:(CCLayer *)layer {
    [layer removeChild:self.sprite cleanup:NO];
    [layer removeChild:self.trail cleanup:NO];
}

-(CGRect) getRect {
    return CGRectMake(self.sprite.position.x - HALF_BULLET_SIZE, 
                      self.sprite.position.y - HALF_BULLET_SIZE, 
                      BULLET_SIZE, 
                      BULLET_SIZE);    
}

@end
