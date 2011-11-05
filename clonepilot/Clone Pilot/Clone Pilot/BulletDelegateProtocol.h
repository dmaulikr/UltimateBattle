#import "Bullet.h"

@protocol BulletDelegate <NSObject>

- (void)fired;
- (void)addBullet:(Bullet *)b;
- (void)addBullets:(NSArray *)bullets;

@end
