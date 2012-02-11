#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "QPShip.h"
#import "VRGeometry.h"
#import "ClonePilotBattlefield.h"

@interface QPBattlefieldModifier : BulletHellBattlefieldModifier

- (void)modifyClonePilotBattlefield:(ClonePilotBattlefield *)f;

@end 
