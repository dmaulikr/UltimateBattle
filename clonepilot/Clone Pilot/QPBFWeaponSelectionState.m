#import "QPBFWeaponSelectionState.h"

@implementation QPBFWeaponSelectionState
@synthesize basicWeapon = _basicWeapon;
@synthesize splitLaser = _splitLaser;
@synthesize display = _display;

- (id)initWithBattlefield:(QPBattlefield *)field {
    self = [super init];
    self.splitLaser = [[[SplitLaser alloc] init] autorelease];
    self.basicWeapon = self.splitLaser;
    return self;
}

- (void)dealloc {
    [_basicWeapon release];
    self.basicWeapon = nil;
    [_display release];
    [super dealloc];
}

@end
