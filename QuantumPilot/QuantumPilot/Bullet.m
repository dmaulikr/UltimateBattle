//
//  Bullet.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "Bullet.h"
#import "VRGeometry.h"

@implementation Bullet
@synthesize l = _l, vel = _vel, identifier = _identifier;
@synthesize yDirection = _yDirection;

- (NSString *)description {
    return [NSString stringWithFormat:@"l: %f,%f    vel:%f,%f    %d", self.l.x, self.l.y, self.vel.x, self.vel.y, self.identifier];
}

- (void)pulse {
    self.l = CombinedPoint(self.l, self.vel);
}

- (void)draw {
    //
}

@end

