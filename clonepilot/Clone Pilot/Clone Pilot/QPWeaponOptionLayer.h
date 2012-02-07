#import "cocos2d.h"
#import "Weapon.h"

@interface QPWeaponOptionLayer : NSObject

@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, retain) CCSprite *weaponSprite;
@property (nonatomic, retain) CCLabelTTF *weaponText;

- (id)initWithWeapon:(Weapon *)w;

- (void)addWeaponOptionsToLayer:(CCLayer *)layer;

- (void)positionDisplayAroundLocation:(CGPoint)l;

- (void)removeDisplay;

@end
