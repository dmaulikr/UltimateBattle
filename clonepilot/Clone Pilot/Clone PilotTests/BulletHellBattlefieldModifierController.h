#import <Foundation/Foundation.h>

@interface BulletHellBattlefieldModifierController : NSObject

@property (nonatomic, retain) NSMutableArray *battlefieldModifiers;
@property (nonatomic, retain) NSMutableArray *chosenBattlefieldModifiers;

- (NSArray *)startingPotentialBattlefieldModifiers;

@end
