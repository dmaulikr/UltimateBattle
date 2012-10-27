#import <Foundation/Foundation.h>
@class QuantumPilot;

@protocol QPBulletDelegate <NSObject>

- (void)bulletsFired:(NSArray *)bullets fromShip:(QuantumPilot *)ship;

@end
