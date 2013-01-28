#import "QuantumPilot.h"
#import "SingleLaser.h"

@implementation QuantumPilot
@synthesize firing = _firing;
@synthesize l = _l;
@synthesize vel = _vel;
@synthesize weapon = _weapon;
@synthesize speed = _speed;
@synthesize radius = _radius;
@synthesize bulletDelegate;

- (void)assignDefaultWeapon {
    SingleLaser *w = [[SingleLaser alloc] init];
    self.weapon = w;
    [w release];
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.l = [ClonePlayer defaultLocation];
//        self.t = self.l;
        [self generateTurn];
        [self assignDefaultWeapon];
  //      self.living = 1;
        self.speed = 5;
        self.radius = 20;
    }
    return self;
}

- (id)init {
    return [self commonInit];
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [self commonInit];
    [layer addChild:self];
    return self;
}

- (void)fire {
    self.firing = YES;
    [self.bulletDelegate fired];
}

- (NSInteger)direction {
    return 1;
}

- (void)fireWeapon {
    NSArray *bullets = [self.weapon newBulletsForLocation:CombinedPoint(self.l, ccp(0, [self direction] * 37)) direction:[self direction]];
    for (Bullet *b in bullets) {
        b.showDefaultColor = YES;
    }
    [self.bulletDelegate addBullets:bullets ship:self];
}

- (void)tick {
    if (self.firing) {
        [self fireWeapon];
    }
    
    [self assignVelocityForTarget];
    [self updateLocationWithVelocity];
     
    /self.t = self.l;
}

- (void)draw {
    [super draw];
}

- (BOOL)isFiring {
    return self.firing;
}

@end
