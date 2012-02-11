#import "QPBulletCollisionModifier.h"

@implementation QPBulletCollisionModifier

- (void)modifyClonePilotBattlefield:(ClonePilotBattlefield *)f {
    for (Bullet *b1 in f.bullets) {
        for (Bullet *b2 in f.bullets) {
            if (b1 != b2 && [b1 isColliding:b2]) {
                if (![b1 isMemberOfClass:[b2 class]]) {   
                    b1.finished = YES;
                    b2.finished = YES;
                    break;
                }
            }
        }
        if (b1.finished) {
            break;
        }
    }
}

@end
