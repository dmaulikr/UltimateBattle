//
//  Bullet.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cmpgames.h"
#import "cocos2d.h"

@interface Bullet : NSObject {
    
}

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, retain) id trail;

-(id) initWithStart:(CGPoint) start withVelocity:(CGPoint) velocity;
-(void) addToLayer:(CCLayer *) layer;
-(void) removeFromLayer:(CCLayer *) layer;
-(void) createTrail;

-(CGRect) getRect;

@end
