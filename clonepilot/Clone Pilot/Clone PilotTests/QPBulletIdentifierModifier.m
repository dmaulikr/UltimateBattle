#import "QPBulletIdentifierModifier.h"

@implementation QPBulletIdentifierModifier

- (void)addBullets:(NSArray *)bullets ship:(QPShip *)ship {
    for (Bullet *b in bullets) {
        b.identifier = [ship identifier];
    }
}

@end
