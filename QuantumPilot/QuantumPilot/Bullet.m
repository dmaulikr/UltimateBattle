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

- (CGPoint)velocity {
    return self.vel;
}

- (void)pulse {
    self.l = CombinedPoint(self.l, [self velocity]);
    self.drawMultiplier = [[QPBattlefield f] isPulsing] ? rs : self.drawMultiplier;
    if (![self.zone isEqualToString:[self zoneKey]]) {
        if (self.tag == -1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BulletMoved" object:self];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CloneBulletMoved" object:self];
        }
    }
}

- (int)yDirection {
    return self.vel.y < 0 ? -1 : 1;
}

- (NSString *)weapon {
    return nil;
}

- (NSString *)zoneKey {
    int x = (int)self.l.x / 50.0f;
    int y = (int)self.l.y / 50.0f;
    return [NSString stringWithFormat:@"%d,%d", x, y];
}

@end

