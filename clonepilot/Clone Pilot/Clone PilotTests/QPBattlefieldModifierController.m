#import "QPBattlefieldModifierController.h"
#import "QPMomentumModifier.h"
#import "QPBulletCollisionModifier.h"

@implementation QPBattlefieldModifierController

- (NSArray *)startingPotentialBattlefieldModifiers {
    return [NSArray arrayWithObjects:[QPMomentumModifier class], [QPBulletCollisionModifier class], nil];
}

@end
