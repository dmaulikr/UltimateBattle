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

@interface QPBFRecycleState : QPBFState

@property (strong, nonatomic) RecycleDisplay *display;

- (void)showWeapon:(NSString *)w;

- (void)reloadDebris:(int)d;

@end
