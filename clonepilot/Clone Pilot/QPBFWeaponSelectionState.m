#import "QPBFWeaponSelectionState.h"
#import "QPBattlefield.h"

@implementation QPBFWeaponSelectionState
@synthesize basicWeapon = _basicWeapon;
@synthesize splitLaser = _splitLaser;
@synthesize display = _display;

- (id)initWithBattlefield:(QPBattlefield *)field {
    self = [super initWithBattlefield:field];
    self.splitLaser = [[[SplitLaser alloc] init] autorelease];
    self.basicWeapon = self.splitLaser;
    self.display = [[[QPWeaponSelectionDisplay alloc] init] autorelease];
    [self.f.layer addChild:self.display];
    return self;
}

- (void)dealloc {
    [_basicWeapon release];
    self.basicWeapon = nil;
    [_display release];
    [super dealloc];
}

@end
