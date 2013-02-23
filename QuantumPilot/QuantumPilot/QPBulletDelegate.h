#import <Foundation/Foundation.h>

@protocol QPBulletDelegate <NSObject>

- (void)bulletsFired:(NSArray *)bullets;
- (void)cloneBulletsFired:(NSArray *)bullets;

@end
