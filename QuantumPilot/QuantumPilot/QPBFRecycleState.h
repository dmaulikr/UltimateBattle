//
//  QPBFRecycleState.h
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "QPBFState.h"
#import "RecycleDisplay.h"

#define QP_RECYCLE_NEXT_WEAPON @"QP_RECYCLE_NEXT_WEAPON"
#define QP_RECYCLE_NEXT_WEAPON_COST @"QP_RECYCLE_NEXT_WEAPON_COST"

@interface QPBFRecycleState : QPBFState

@property (strong, nonatomic) RecycleDisplay *display;

- (void)showWeapon:(NSString *)w;
- (void)showWeapon:(NSString *)w cost:(int)cost;
- (void)showWarningActivated:(bool)w;

- (void)reloadDebris:(int)d;

@end
