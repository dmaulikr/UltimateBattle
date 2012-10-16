#import "cocos2d.h"
#import "Weapon.h"

@interface QPWeaponSelectionDisplay : CCNode

@property (nonatomic, retain) CCLabelTTF *basicWeaponLabel;

- (id)initWithBasicWeapon:(Weapon *)weapon layer:(CCLayer *)layer;

@end
