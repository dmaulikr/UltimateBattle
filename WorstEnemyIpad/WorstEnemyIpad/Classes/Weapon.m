//
//  Weapon.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "Weapon.h"


@implementation Weapon

@synthesize cooldown;
@synthesize cooldownRate;

-(id) init {
    self = [super init];
    if (self) {
        self.cooldown=0;
        self.cooldownRate=50; 
    }
    return self;
}

-(BOOL) canFire {
    return cooldown <= 0;
}

-(NSArray *) getBullets:(CGPoint) point {
    if ([self canFire]) {
        NSMutableArray * bullets = [NSMutableArray array]; 
        WBullet *b = [[WBullet alloc] initWithStart:point];
        [bullets addObject:b];
        [b release];
        self.cooldown = self.cooldownRate;
        return bullets;
    } else {
        self.cooldown--;
        return nil;
    }
}

-(NSArray *) getEnemyBullets:(CGPoint) point {
    if ([self canFire]) {
        NSMutableArray * bullets = [NSMutableArray array]; 
        EnemyBullet *b = [[EnemyBullet alloc] initWithStart:(point)];
        [bullets addObject:b];
        [b release];
        self.cooldown = self.cooldownRate;
        return bullets;
    } else {
        self.cooldown--;
        return nil;
    }    
}

@end
