//
//  BulletHellBattlefield.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "BulletHellBattlefield.h"

@implementation BulletHellBattlefield

@synthesize bullets;
@synthesize level;

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
        self.level = 0;
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

    [self.bullets removeObjectsInArray:removableBullets];
    
    
    for (Bullet *b in self.bullets) {
        [b tick];
    }
}

- (void)tick {
    [self bulletLoop];
}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)dealloc {
    [bullets release];
    [super dealloc];
}

@end
