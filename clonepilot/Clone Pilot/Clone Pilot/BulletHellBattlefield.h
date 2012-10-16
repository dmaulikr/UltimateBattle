#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "BulletDelegateProtocol.h"
#import "BulletHellBattlefieldModifier.h"
#import "BulletHellBattlefieldModifierController.h"

@interface BulletHellBattlefield : CCNode <BulletDelegate> {

}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, retain) NSMutableArray *battlefieldModifiers;
@property (nonatomic, retain) BulletHellBattlefieldModifierController *battlefieldModifierController;

- (void)tick;
- (void)addBullet:(Bullet *)b;
- (void)bulletLoop;
- (void)removeBullets;
- (void)setupBattlefieldModifiers;
- (void)addBullets:(NSArray *)bullets;

- (void)addBattlefieldModifier:(BulletHellBattlefieldModifier *)m;

- (void)setupPotentialBattlefieldModifiers;

@end