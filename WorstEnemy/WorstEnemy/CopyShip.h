//
//  CopyShip.h
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UltimateShip.h"

@interface CopyShip : UltimateShip {
	int currentTurnIndex;
}

-(id)initWithShip:(UltimateShip *)ship;

-(void)resetState;

@end