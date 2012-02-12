#import "ClonePilot.h"
#import "VRGeometry.h"
#import "QPCloneShip.h"

static int QP_ClonePilotYDirection = -1;

@implementation ClonePilot
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize living;
@synthesize weapon;
@synthesize moveIndex;
@synthesize bulletDelegate;
@synthesize sprite;
@synthesize ship;

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 724);
}

+ (NSInteger)identifier {
    return 1;
}

- (Turn *)currentTurn {
    return [self.moves objectAtIndex:self.moveIndex];
}

- (Bullet *)newBullet {
    Bullet *b = [[[Bullet alloc] initWithLocation:self.l velocity:CGPointMake(0,3)] autorelease];
    b.identifier = [ClonePilot identifier];
    return b;
}

- (void)manageFiringForTurn:(Turn *)turn {
    if (turn.firing) {
        NSArray *bullets = [self.weapon newBulletsForLocation:self.l direction:QP_ClonePilotYDirection];
        self.ship.vel = self.vel;
        [self.bulletDelegate addBullets:bullets ship:self.ship];
    }
}

- (void)manageMoveIndexBoundary {
    if (self.moveIndex >= [self.moves count] || self.moveIndex < 0){
        _moveDirection = -_moveDirection;
        self.moveIndex +=2 *_moveDirection;
    }
}

- (void)tick {
    if ([self living]) {
        if ([self.moves count] > 0) {
            Turn *turn = [self.moves objectAtIndex:self.moveIndex];
            self.vel = turn.vel;
            self.vel = CGPointMake(self.vel.x * _moveDirection, self.vel.y * _moveDirection);
            self.l = CombinedPoint(self.l, self.vel);
            [self manageFiringForTurn:turn];
            
            self.moveIndex +=_moveDirection;
            [self manageMoveIndexBoundary];
            
        }
        
        if (self.sprite) {
            self.sprite.position = self.l;
        }
    }
}

- (void)reset {
    self.l = [ClonePilot defaultLocation];
    self.moveIndex = 0;
    _moveDirection = 1;
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.l = [ClonePilot defaultLocation];
        self.moves = [NSMutableArray array];
        self.living = YES;
        self.radius = 23;
        _moveDirection = 1;
        self.ship = [[[QPCloneShip alloc] init] autorelease];
    }
    
    return self;
}

- (id)init {
    return [self commonInit];
}

- (void)resetSpriteWithLayer:(CCLayer *)layer {
    [self.sprite removeFromParentAndCleanup:YES];
    self.sprite = nil;
    self.sprite = [CCSprite spriteWithFile:@"sprite-7-1.png"];
    [layer addChild:self.sprite];
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [self commonInit];
    [self resetSpriteWithLayer:layer];
    
    return self;
}

- (void)dealloc {
    [moves release];
    [weapon release];
    self.bulletDelegate = nil;
    [sprite release];
    [ship release];
    [super dealloc];
}

@end
