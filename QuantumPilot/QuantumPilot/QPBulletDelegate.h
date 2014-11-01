#import <Foundation/Foundation.h>

@protocol QPBulletDelegate <NSObject>

- (void)bulletsFired:(NSArray *)bullets li:(int)li;
- (void)cloneBulletsFired:(NSArray *)bullets li:(int)li;

@end
