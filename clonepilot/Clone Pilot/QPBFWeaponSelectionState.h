#import "QPBFState.h"
#import "Weapon.h"
#import "SplitLaser.h"
#import "QPWeaponSelectionDisplay.m"

@interface QPBFWeaponSelectionState : QPBFState

@property (nonatomic, retain) Weapon *basicWeapon;
@property (nonatomic, retain) SplitLaser *splitLaser;
@property (nonatomic, retain) QPWeaponSelectionDisplay *display;

@end
