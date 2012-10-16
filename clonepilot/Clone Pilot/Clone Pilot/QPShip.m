#import "QPShip.h"

int historicalTurnsCount = 50;

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
        [self clearHistoricalPoints];        
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

- (CGPoint)defaultLocation {
    return ccp(384,512);
}

- (void)clearHistoricalPoints {
    for (int i = 0; i < historicalTurnsCount; i++) {
        historicalPoints[i] = [self defaultLocation];
    }
}

- (void)updateHistoricalPoints {
    historicalPoints[historicalTurnsCount] = self.l;
    for (int i = 0; i < historicalTurnsCount; i++) {
        historicalPoints[i] = historicalPoints[i+1];
        historicalPoints[i] = ccp(historicalPoints[i].x,historicalPoints[i].y-(.5 *[self yDirection]));
    }
}

- (void)setDrawingColor {
    
}

- (void)draw {
//    if (self.living) {
//        [self setDrawingColor];
//        ccDrawPoly(historicalPoints, historicalTurnsCount, NO);
//    }
}

- (void)tick {
    [self updateHistoricalPoints];
}

- (NSInteger)yDirection {
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
