#import "QPClonePlayerShip.h"
#import "QPDrawing.h"

@implementation QPClonePlayerShip

- (BOOL)shipHitByBullet:(Bullet *)b {
    return shapeOfSizeContainsPoint(lines, 4, b.l);
}

- (NSInteger)identifier {
    return 0;
}

- (void)draw {
    if (self.living) {
        glColor4f(1, 1, 1, 1.0);
        drawBasicDiamondShip(self.l, -1);
    }
}

@end
