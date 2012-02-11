#import "BulletHellBattlefieldModifierController.h"
#import "BulletHellBattlefieldModifier.h"

@implementation BulletHellBattlefieldModifierController
@synthesize battlefieldModifiers;
@synthesize chosenBattlefieldModifiers;

- (NSArray *)startingPotentialBattlefieldModifiers {
    return [NSArray array];
}

- (NSArray *)initializedBattlefieldModifiers:(NSArray *)modifierClasses {
    NSMutableArray *modifiers = [NSMutableArray array];
    for (Class c in modifierClasses) {
        BulletHellBattlefieldModifier *m = [[c alloc] init];
        [modifiers addObject:m];
        [m release];
    }
    
    return modifiers;
}

- (id)init {
    self = [super init];
    if (self) {
        NSArray *startingBattlefieldModifiers = [self initializedBattlefieldModifiers:[self startingPotentialBattlefieldModifiers]];
        self.battlefieldModifiers = [NSMutableArray arrayWithArray:startingBattlefieldModifiers];
        self.chosenBattlefieldModifiers = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc {
    [battlefieldModifiers release];
    [chosenBattlefieldModifiers release];
    [super dealloc];
}

@end
