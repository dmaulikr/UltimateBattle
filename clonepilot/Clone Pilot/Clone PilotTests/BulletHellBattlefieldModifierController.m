#import "BulletHellBattlefieldModifierController.h"
#import "BulletHellBattlefieldModifier.h"
#import "BulletHellBattlefield.h"

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

- (void)levelGainedForBattlefield:(BulletHellBattlefield *)f {
    if (f.level > 0 && f.level % 10 == 0) {
        if ([self.battlefieldModifiers count] > 0) {
            BulletHellBattlefieldModifier *m = [self.battlefieldModifiers objectAtIndex:0];
            [self.chosenBattlefieldModifiers addObject:m];
            [self.battlefieldModifiers removeObject:m];
            [f addBattlefieldModifier:m];
        }
    }
    
}

- (void)dealloc {
    [battlefieldModifiers release];
    [chosenBattlefieldModifiers release];
    [super dealloc];
}

@end
