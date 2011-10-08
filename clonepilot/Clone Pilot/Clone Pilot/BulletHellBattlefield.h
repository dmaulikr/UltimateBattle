//
//  BulletHellBattlefield.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

@interface BulletHellBattlefield : NSObject {
    NSInteger _level;
}

@property (nonatomic, retain) NSMutableArray *bullets;

- (NSInteger)level;
- (void)tick;
- (void)addBullet:(Bullet *)b;

- (void)bulletLoop;

@end