#import "ClonePilot.h"

int QP_ClonePilotYDirection = -1;

@implementation ClonePilot
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize living;
@synthesize moveIndex;
@synthesize bulletDelegate;

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 724);
}

- (CGPoint)defaultLocation {
    return [ClonePilot defaultLocation];
}

+ (NSInteger)identifier {
    return 1;
}

- (NSInteger)identifier {
    return [ClonePilot identifier];   
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
        NSArray *bullets = [self.weapon newBulletsForLocation:CombinedPoint(self.l, ccp(0,QP_ClonePilotYDirection * 37)) direction:QP_ClonePilotYDirection];
        [self.bulletDelegate addBullets:bullets ship:self];
    }
}

- (NSInteger)yDirection {
    return QP_ClonePilotYDirection;
}

- (void)manageMoveIndexBoundary {
    if (self.moveIndex >= [self.moves count] || self.moveIndex < 0){
        _moveDirection = -_moveDirection;
        self.moveIndex +=2 *_moveDirection;
    }
}

- (void)tick {
    [super tick];
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
    
    }
}

- (void)reset {
    self.l = [ClonePilot defaultLocation];
    [self clearHistoricalPoints];
    self.moveIndex = 0;
    _moveDirection = 1;
    self.living = YES;
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.l = [ClonePilot defaultLocation];
        self.moves = [NSMutableArray array];
        self.living = YES;
        self.radius = 23;
        _moveDirection = 1;
    }
    
    return self;
}

- (id)init {
    return [self commonInit];
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [self commonInit];
    [layer addChild:self z:100];
    
    return self;
}

- (void)ceaseLiving {
    self.living = NO;
}

- (BOOL)shipHitByBullet:(Bullet *)b {
    CGPoint *shipLines = basicDiamondShipLines(self.l, QP_ClonePilotYDirection);
    return shapeOfSizeContainsPoint(shipLines, 4, b.l);
}

- (void)setDrawingColor {
    if (self.weapon) {
        [self.weapon setDrawColor];
    } else {
        glColor4f(1, 1, 1, 1.0);
    }
}

- (void)draw {
    [super draw];
    if (self.living) {
        drawBasicDiamondShip(self.l, QP_ClonePilotYDirection);
    }
}


- (void)dealloc {
    [moves release];
    self.bulletDelegate = nil;
    [super dealloc];
}

@end
