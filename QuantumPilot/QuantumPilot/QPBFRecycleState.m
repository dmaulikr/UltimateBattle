//
//  QPBFRecycleState.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "QPBFRecycleState.h"
#import "QPBattlefield.h"

@implementation QPBFRecycleState

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self.f changeState:self.f.pausedState withTouch:l];
    }
}

- (void)activate:(NSDictionary *)options {
    self.display = [[[RecycleDisplay alloc] init] autorelease];
    
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
