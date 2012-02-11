//
//  BulletHellBattlefield.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "BulletDelegateProtocol.h"
#import "BulletHellBattlefieldModifier.h"

@interface BulletHellBattlefield : NSObject <BulletDelegate> {

}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, retain) NSMutableArray *battlefieldModifiers;

- (void)tick;
- (void)addBullet:(Bullet *)b;
- (void)bulletLoop;
- (void)setupBattlefieldModifiers;
- (void)addBullets:(NSArray *)bullets;

- (void)addBattlefieldModifier:(BulletHellBattlefieldModifier *)m;

@end