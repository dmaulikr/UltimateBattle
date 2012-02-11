#import <Foundation/Foundation.h>
#import "BulletDelegateProtocol.h"

@class BulletHellBattlefield;

@interface BulletHellBattlefieldModifier : NSObject <BulletDelegate>

- (void)modifyBattlefield:(BulletHellBattlefield *)f;

@end
