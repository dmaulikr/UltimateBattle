#import <Foundation/Foundation.h>
#import "BulletHellBattlefieldModifier.h"

@interface BulletHellBattlefieldModifierController : BulletHellBattlefieldModifier

@property (nonatomic, retain) NSMutableArray *battlefieldModifiers;
@property (nonatomic, retain) NSMutableArray *chosenBattlefieldModifiers;

- (NSArray *)startingPotentialBattlefieldModifiers;

@end
