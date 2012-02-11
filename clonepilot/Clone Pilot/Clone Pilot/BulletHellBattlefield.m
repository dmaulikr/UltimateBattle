//
//  BulletHellBattlefield.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "BulletHellBattlefield.h"
#import "QPBattlefieldModifier.h"

@implementation BulletHellBattlefield

@synthesize bullets;
@synthesize level;
@synthesize battlefieldModifiers;

- (void)setupBattlefieldModifiers { 

}

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
        self.level = 0;
        self.battlefieldModifiers = [NSMutableArray array];
        [self setupBattlefieldModifiers];
    }
    
    return self;
}

- (void)bulletLoop {
    NSMutableArray *removableBullets = [NSMutableArray array];

    for (Bullet *b in self.bullets) {
        if (b.finished) {
            [removableBullets addObject:b];
        }
    }

    for (Bullet *b in removableBullets) {
        if (b.sprite) {
            [b.sprite removeFromParentAndCleanup:YES];
        }
    }
    
    [self.bullets removeObjectsInArray:removableBullets];
    
    
    for (Bullet *b in self.bullets) {
        [b tick];
    }
}

- (void)addBullets:(NSArray *)bullets_ {
    for (Bullet *b in bullets_) {
        [self.bullets addObject:b];
    }
}

- (void)addBullets:(NSArray *)bullets_ ship:(QPShip *)ship {
    for (QPBattlefieldModifier *m in self.battlefieldModifiers) {
        [m addBullets:bullets_ ship:ship];
    }
    [self addBullets:bullets_];
}

- (void)fired {
    
}

- (void)modifierLoop {
    for (BulletHellBattlefieldModifier *m in self.battlefieldModifiers) {
        [m modifyBattlefield:self];
    }
}

- (void)tick {
    [self modifierLoop];
    [self bulletLoop];

}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)addBattlefieldModifier:(BulletHellBattlefieldModifier *)m {
    [self.battlefieldModifiers addObject:m];
}

- (void)dealloc {
    [bullets release];
    [battlefieldModifiers release];    
    [super dealloc];
}

@end
