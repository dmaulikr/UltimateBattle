#import "QPBattlefieldModifierController.h"
#import "QPMomentumModifier.h"

@implementation QPBattlefieldModifierController

- (NSArray *)startingPotentialBattlefieldModifiers {
    return [NSArray arrayWithObjects:[QPMomentumModifier class], nil];
}

@end
