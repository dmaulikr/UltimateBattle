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
                [self.f changeState:self.f.pausedState];
            }
        } else if (l.y > p.y + 20) {
            if ([self.f installShield]) {
                [self.f changeState:self.f.pausedState];
            }
        }
    } else if (l.x > p.x + 20) {
        if (l.y < p.y - 20) {
            if ([self.f installBomb]) {
                [self.f changeState:self.f.pausedState];
            }
        } else if (l.y > p.y + 20) {
            if ([self.f installNewWeapon]) {
                [self.f changeState:self.f.pausedState];
            }
        }
    }
}

- (void)activate:(NSDictionary *)options {
    self.display = [[[RecycleDisplay alloc] init] autorelease];
    //show options
    //show pay
    [self.f addChild:self.display];
}

- (void)deactivate {
    [self.display removeAllChildrenWithCleanup:true];
    [self.f removeChild:self.display cleanup:true];
    self.display = nil;
}

- (void)pulse {
    
}


@end
