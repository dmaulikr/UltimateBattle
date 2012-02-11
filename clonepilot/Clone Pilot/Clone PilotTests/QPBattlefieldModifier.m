#import "QPBattlefieldModifier.h"

@implementation QPBattlefieldModifier

- (void)modifyClonePilotBattlefield:(ClonePilotBattlefield *)f {
}

- (void)modifyBattlefield:(BulletHellBattlefield *)f {
    [self modifyClonePilotBattlefield:(ClonePilotBattlefield *)f];
}

@end
