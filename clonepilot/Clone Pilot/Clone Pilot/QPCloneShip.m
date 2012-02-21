#import "QPCloneShip.h"
#import "QPDrawing.h"

@implementation QPCloneShip

- (BOOL)shipHitByBullet:(Bullet *)b {
    CGPoint *shipLines = basicDiamondShipLines(self.l, 1);
    return shapeOfSizeContainsPoint(shipLines, 4, b.l);
}

- (void)draw {
    if (self.living) {
        if (self.weapon) {
            [self.weapon setDrawColor];
        } else {
            glColor4f(1, 1, 1, 1.0);
        }

        drawBasicDiamondShip(self.l, 1);
    }
}


- (NSInteger)identifier {
    return 1;
}

@end
