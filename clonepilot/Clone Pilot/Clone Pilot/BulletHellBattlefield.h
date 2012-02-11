#import <Foundation/Foundation.h>
#import "Bullet.h"
#import "BulletDelegateProtocol.h"
#import "BulletHellBattlefieldModifier.h"
#import "BulletHellBattlefieldModifierController.h"

@interface BulletHellBattlefield : NSObject <BulletDelegate> {

}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, retain) NSMutableArray *battlefieldModifiers;
@property (nonatomic, retain) BulletHellBattlefieldModifierController *battlefieldModifierController;
//@property (nonatomic, retain) NSMutableArray *potentialBattlefieldModifiers;

- (void)tick;
- (void)addBullet:(Bullet *)b;
- (void)bulletLoop;
- (void)setupBattlefieldModifiers;
- (void)addBullets:(NSArray *)bullets;

- (void)addBattlefieldModifier:(BulletHellBattlefieldModifier *)m;

- (void)setupPotentialBattlefieldModifiers;

@end