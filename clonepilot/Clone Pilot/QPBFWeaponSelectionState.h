#import "QPBFState.h"
#import "Weapon.h"
#import "SplitLaser.h"
#import "QPWeaponSelectionDisplay.h"
#import "SingleLaser.h"

@interface QPBFWeaponSelectionState : QPBFState

@property (nonatomic, retain) Weapon *basicWeapon;
@property (nonatomic, retain) SplitLaser *splitLaser;
@property (nonatomic, retain) SingleLaser *singleLaser;
@property (nonatomic, retain) QPWeaponSelectionDisplay *display;

@end
