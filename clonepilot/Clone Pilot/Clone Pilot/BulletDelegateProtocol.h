#import "Bullet.h"
@class QPShip;

@protocol BulletDelegate <NSObject>

- (void)fired;
- (void)addBullets:(NSArray *)bullets ship:(QPShip *)ship;


@end
