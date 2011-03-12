//
//  Ship.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"
#import "GameObject.h"
#define Ship_HP 100

@interface Ship : GameObject {

}

@property(nonatomic, retain) NSMutableArray *moves;
@property(nonatomic) int hp;
@property(nonatomic, retain) Weapon *weapon;


@end
