//
//  KillerBar.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/31/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "KillerBar.h"


@implementation KillerBar

@synthesize sprite;

#define START_POINT ccp(0,175)
#define END_POINT ccp(500,175)
#define SPEED 1
#define BAR_SIZE 50
#define HALF_BAR_SIZE 25

-(id) init {
    self = [super init];
    
    if (self) {
        self.sprite = [CCSprite spriteWithFile:@"killer_bar.png"];
        self.sprite.position = START_POINT;
    }
    
    return self;
}

-(CGRect) getRect {
    return CGRectMake(self.sprite.position.x - HALF_BAR_SIZE, 
                      self.sprite.position.y - 250, 
                      BAR_SIZE,
                      500);
}

-(void) addToLayer:(CCLayer *)layer {
    [layer addChild:self.sprite];
}

-(void) reset {
    [self.sprite stopAllActions];
    self.sprite.position = START_POINT;
    
    CCMoveTo *pause = [CCMoveTo actionWithDuration:2 position:START_POINT];
    CCMoveTo *moveTo = [CCMoveTo actionWithDuration:50 position:END_POINT];
    [self.sprite runAction:[CCSequence actionOne:pause two:moveTo]];
}

@end
