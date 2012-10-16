#import "QPBFWeaponSelectionState.h"
#import "QPBattlefield.h"

@implementation QPBFWeaponSelectionState
@synthesize basicWeapon = _basicWeapon;
@synthesize splitLaser = _splitLaser;
@synthesize singleLaser = _singleLaser;
@synthesize display = _display;


- (id)initWithBattlefield:(QPBattlefield *)field {
    self = [super initWithBattlefield:field];
    self.splitLaser = [[[SplitLaser alloc] init] autorelease];
    self.singleLaser = [[[SingleLaser alloc] init] autorelease];
    self.basicWeapon = self.splitLaser;
    self.display = [[[QPWeaponSelectionDisplay alloc] initWithBasicWeapon:self.basicWeapon layer:self.f.layer] autorelease];
    return self;
}

- (void)addTouch:(CGPoint)l {
    self.f.player.weapon = self.basicWeapon;
    if (self.basicWeapon == self.singleLaser) {
        self.basicWeapon = self.splitLaser;
    } else {
        self.basicWeapon = self.singleLaser;
    }
    [self.f changeState:self.f.pausedState];
    
}

- (void)dealloc {
    self.basicWeapon = nil;
    self.singleLaser = nil;
    self.splitLaser = nil;
    [self.display removeFromParentAndCleanup:YES];
    self.display = nil;
    [super dealloc];
}

@end
