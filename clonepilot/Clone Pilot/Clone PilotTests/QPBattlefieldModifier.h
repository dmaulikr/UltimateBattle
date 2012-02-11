//
//  QPBattlefieldModifier.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 2/11/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "QPShip.h"
#import "VRGeometry.h"
#import "ClonePilotBattlefield.h"

@interface QPBattlefieldModifier : BulletHellBattlefieldModifier

- (void)modifyClonePilotBattlefield:(ClonePilotBattlefield *)f;

@end 
