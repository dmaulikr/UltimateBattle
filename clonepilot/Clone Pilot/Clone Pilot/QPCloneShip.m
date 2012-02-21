#import "QPCloneShip.h"

@implementation QPCloneShip

- (BOOL)shipHitByBullet:(Bullet *)b {
    return shapeOfSizeContainsPoint(lines, 4, b.l);
}

- (void)draw {
    if (self.living) {
        if (self.weapon) {
            [self.weapon setDrawColor];
        } else {
            glColor4f(1, 1, 1, 1.0);
        }
        lines[0] = ccp(self.l.x-16,self.l.y);
        lines[1] = ccp(self.l.x,self.l.y+10);
        lines[2] = ccp(self.l.x+16,self.l.y);
        lines[3] = ccp(self.l.x,self.l.y-37);
        ccDrawPoly(lines, 4, YES);
    }
}


- (NSInteger)identifier {
    return 1;
}

@end
