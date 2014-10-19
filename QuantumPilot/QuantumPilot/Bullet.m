//
//  Bullet.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "Bullet.h"
#import "VRGeometry.h"
#import "QPBattlefield.h"

@implementation Bullet

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super init];
    if (self) {
        self.l = location;
        self.vel = velocity;
        self.radius = 1.5; //iPad: 3
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"l: %f,%f    vel:%f,%f    %d", self.l.x, self.l.y, self.vel.x, self.vel.y, self.identifier];
}

- (void)pulse {
    self.l = CombinedPoint(self.l, self.vel);
    self.drawMultiplier = [[QPBattlefield f] isPulsing] ? rs : self.drawMultiplier;
}

- (int)yDirection {
    return self.vel.y < 0 ? -1 : 1;
}

- (NSString *)weapon {
    return nil;
}

@end

