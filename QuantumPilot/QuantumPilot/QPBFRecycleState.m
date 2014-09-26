////
//  QPBFRecycleState.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "QPBFRecycleState.h"
#import "QPBattlefield.h"
#import "VRGeometry.h"

@implementation QPBFRecycleState

- (void)addTouch:(CGPoint)l {
    CGPoint p = self.f.pilot.l;
    if (GetDistance(l, p) < 40) {
        [self.f changeState:self.f.pausedState withTouch:l];
    } else if (l.x < p.x - 20) {
        if (l.y < p.y - 20) {
            if ([self.f installWarning]) {
                
            }
        } else if (l.y > p.y + 20) {
            if ([self.f installShield]) {
                
            }
        }
    } else if (l.x > p.x + 20) {
        if (l.y < p.y - 20) {
            if ([self.f installSlow]) {
                
            }
        } else if (l.y > p.y + 20) {
            if ([self.f installNextWeapon]) {
                
            }
        }
    }
}

- (void)activate:(NSDictionary *)options {
    self.display = [[[RecycleDisplay alloc] init] autorelease];
    //show options
    //show pay
    int cost = [options[QP_RECYCLE_NEXT_WEAPON_COST] intValue];
    [self showWeapon:options[QP_RECYCLE_NEXT_WEAPON] cost:cost];

    [self.f addChild:self.display];
}

- (void)deactivate {
    [self.display removeAllChildrenWithCleanup:true];
    [self.f removeChild:self.display cleanup:true];
    self.display = nil;
}

- (void)pulse {
    
}

- (void)showWeapon:(NSString *)w {
    [self.display showWeapon:w];
}

- (void)showWeapon:(NSString *)w cost:(int)cost {
    [self.display showWeapon:w cost:cost];
}

- (void)showWarningActivated:(bool)w {
    [self.display showWarningActivated:w];
}

- (void)showSlow:(bool)s {
    [self.display showSlow:s];
}

- (void)reloadDebris:(int)d {
    [self.display reloadDebrisLabel:d];
}

@end
