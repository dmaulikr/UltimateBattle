//
//  Ship.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UltimateWeapon.h"
#import "GameObject.h"
#import "Engine.h"

#define Ship_HP 100

@class UltimateWeapon;

@interface UltimateShip : GameObject {

}

@property(nonatomic) int currentWeaponIndex;
@property(nonatomic, retain) NSMutableArray *moves;
@property(nonatomic) int hp;
@property(nonatomic, retain) NSMutableArray *weapons;
@property(nonatomic, retain) NSMutableArray *bullets;
@property(nonatomic, retain) Engine *engine;

-(UltimateWeapon *)currentWeapon;
-(void)resetTurn;
-(void)cycleWeapon;
-(void)changeWeapon:(int)newWeaponIndex;
-(void)eraseAllWeapons;

-(void)addWeapon:(UltimateWeapon *)weapon;

-(id)initWithYFacing:(int)facing;

-(void)resetTurns;

@end
