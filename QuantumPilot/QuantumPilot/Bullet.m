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
        self.crushes = 0;
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

    if (self.zx != [self calcZx] || self.zy != [self calcZy]) {
        self.zx = (int)self.l.x / 50.0f;
        self.zy = (int)self.l.y / 50.0f;
        if (self.tag == -1) {
            [self.delegate bulletChangedZone:self];
        } else {
            [self.delegate cloneBulletChangedZone:self];
        }
    }
}

- (int)yDirection {
    return self.vel.y < 0 ? -1 : 1;
}

- (NSString *)weapon {
    return nil;
}

- (int)calcZx {
    return (int)self.l.x / 50.0f;
}

- (int)calcZy {
    return (int)self.l.y / 50.0f;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

- (NSString *)zoneKey {
    return [NSString stringWithFormat:@"%d,%d", self.zx, self.zy];
}

- (void)crushBullet:(Bullet *)b {
    b.l = ccp(5000,5000);
    self.l = ccp(5000,5000);
}

@end

