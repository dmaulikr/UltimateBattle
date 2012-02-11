#import "QPShip.h"

@implementation QPShip
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize weapon;
@synthesize health;
@synthesize bulletDelegate;
@synthesize lastBulletsFired;
@synthesize weaponDirection;

- (void)fire {
    [lastBulletsFired release];
    self.lastBulletsFired = nil;
    self.lastBulletsFired = [self.weapon newBulletsForLocation:self.l direction:self.weaponDirection];
    [self.bulletDelegate addBullets:self.lastBulletsFired ship:self];
}

- (BOOL)living {
    return self.health > 0;
}

- (NSInteger)identifier {
    return 0;
}

- (void)dealloc {
    [moves release];
    [weapon release];
    self.bulletDelegate = nil;
    [lastBulletsFired release];
    [super dealloc];
}

@end
