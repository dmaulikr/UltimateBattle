//
//  KillerBar.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/31/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KillerBar : NSObject {
    
}

@property (nonatomic, retain) CCSprite *sprite;

-(void) addToLayer:(CCLayer *) layer;
-(CGRect) getRect;
-(void)reset;

@end
