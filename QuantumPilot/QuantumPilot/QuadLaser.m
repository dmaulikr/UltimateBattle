#import "QuadLaser.h"
#import "QPBattlefield.h"
#import "QuadLaserCannon.h"

@implementation QuadLaser

static float halfSegment = 3;

- (float)xDrawRate {
    return .4;
}

- (float)yDrawRate {
    return .6;
}

- (void)draw {
    [QuadLaserCannon setDrawColor];
    int xDirection = 0;
    if (self.vel.x < 0) {
        xDirection = -1;
    } else if (self.vel.x > 0) {
        xDirection = 1;
    }
    
    int yDirection = [self yDirection];
    
    lines[0] = ccp(self.l.x + (xDirection * halfSegment * [self xDrawRate]), self.l.y + (yDirection * halfSegment * [self yDrawRate]));
    lines[1] = ccp(self.l.x - (xDirection * halfSegment * [self xDrawRate]), self.l.y - (yDirection * halfSegment * [self yDrawRate]));
    
    ccDrawPoly(lines, 2, true);

    
}


@end
