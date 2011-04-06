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
        self.cooldownRate=20; 
    }
    return self;
}

-(BOOL) canFire {
    return cooldown <= 0;
}

-(NSArray *) getBullets:(CGPoint) point {
    if ([self canFire]) {
        NSMutableArray * bullets = [NSMutableArray array]; 
        Bullet *b = [[Bullet alloc] initWithStart:(point) withVelocity:ccp(-3,0)];
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
