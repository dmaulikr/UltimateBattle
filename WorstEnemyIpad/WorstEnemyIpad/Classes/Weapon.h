//
//  Weapon.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cmpgames.h"
#import "WBullet.h"
#import "cocos2d.h"
#import "EnemyBullet.h"

@interface Weapon : NSObject {
    
}

@property (nonatomic) int cooldown;
@property (nonatomic) int cooldownRate;

-(NSArray *) getBullets:(CGPoint) point;
-(NSArray *) getEnemyBullets:(CGPoint) point;

@end
