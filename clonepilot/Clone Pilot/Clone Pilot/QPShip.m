#import "QPShip.h"

@implementation QPShip
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize weapon;
@synthesize living;
@synthesize bulletDelegate;
@synthesize lastBulletsFired;
@synthesize weaponDirection;

- (id)init {
    self = [super init];
    if (self) {
        self.moves = [NSMutableArray array];
        self.living = 1;
    }
    
    return self;
}

- (void)fire {
    [lastBulletsFired release];
    self.lastBulletsFired = nil;
    self.lastBulletsFired = [self.weapon newBulletsForLocation:self.l direction:self.weaponDirection];
    [self.bulletDelegate addBullets:self.lastBulletsFired ship:self];
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
