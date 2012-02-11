#import "Bullet.h"
@class QPShip;

@protocol BulletDelegate <NSObject>

- (void)fired;
- (void)addBullet:(Bullet *)b;
- (void)addBullets:(NSArray *)bullets;
- (void)addBullet:(Bullet *)b ship:(QPShip *)ship;
- (void)addBullets:(NSArray *)bullets ship:(QPShip *)ship;


@end
