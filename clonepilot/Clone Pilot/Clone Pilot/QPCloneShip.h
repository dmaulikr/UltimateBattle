#import "QPShip.h"

@interface QPCloneShip : QPShip {
    CGPoint lines[4];
}

- (BOOL)shipHitByBullet:(Bullet *)b;

@end
