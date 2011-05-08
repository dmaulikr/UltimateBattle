//
//  Weapon.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "cmpgames.h"

@class Bullet;

@interface UltimateWeapon : NSObject <NSCopying>{

}

@property(nonatomic) int repeatLeft;
@property(nonatomic) int repeatReset;
@property(nonatomic, retain) Bullet *bullet;

-(void)tick;
-(NSArray *)fireWithYFacing:(int)facing from:(CGPoint)from;
-(BOOL)canFire;

@end
