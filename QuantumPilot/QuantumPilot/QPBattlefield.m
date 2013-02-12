#import "QPBattlefield.h"
#import "Bullet.h"
#import "QuantumClone.h"

@implementation QPBattlefield

#pragma mark setup

static QPBattlefield *instance = nil;

+ (QPBattlefield *)f {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPBattlefield alloc] init];
    });
    
    return instance;
}

- (void)dealloc {
    [_pilot removeFromParentAndCleanup:YES];
    self.pilot = nil;
    self.layer = nil;
    [super dealloc];
}

- (void)setupPulses {
    _pulseTimes[0] = 10;
    _pulseTimes[1] = 10;
    _pulseTimes[2] = 5;
    _pulseTimes[3] = 5;
    _breaths = 0;
    _breathCycle = 30;
    _breathFlow = 1;
}

- (void)setupPilot {
    self.pilot = [[[QuantumPilot alloc] init] autorelease];
    self.pilot.pilotDelegate = self;
    self.pilot.bulletDelegate = self;
    [self addChild:self.pilot];
    self.pilot.l = ccp(100, 200);
}

- (void)setupStates {
    self.titleState = [[QPBFTitleState alloc] initWithBattlefield:self];
    self.drawingState = [[QPBFDrawingState alloc] initWithBattlefield:self];
    self.pausedState =  [[QPBFPausedState alloc] initWithBattlefield:self];
    self.fightingState = [[QPBFFightingState alloc] initWithBattlefield:self];
    self.currentState = self.titleState;
}

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
        [self setupPulses];
        [self setupPilot];
        [self setupStates];
        [self setupClones];
    }
    return self;
}

- (float)pulseRotation {
    return _breaths / _breathCycle;
}

+ (float)pulseRotation {
    return [[QPBattlefield f] pulseRotation];
}

+ (float)rhythmScale {
    QPBattlefield *battlefield = [QPBattlefield f];
    return [battlefield rhythmScale];
}

- (float)rhythmScale {
    return _rhythmScale;
}

#pragma mark Pulse

- (void)rhythmPulse {
    _pulseCharge++;
    _breaths+= _breathFlow;
    if (_pulseCharge >= _pulseTimes[_pulseState]) {
        _pulseCharge = 0;
        _pulseState++;
        if (_pulseState > 3) {
            _pulseState = 0;
            _breathFlow = -_breathFlow;
        }
    }
    
    float progress = (float)_pulseCharge / (float)_pulseTimes[_pulseState];
    switch (_pulseState) {
        case resting:
            _rhythmScale = .3;
            break;
        case holding:
            _rhythmScale = 1;
            break;
        case charging:
            _rhythmScale = .6 + progress * .5;
            break;
        case falling:
            _rhythmScale = 1.2 - progress * .6;
            break;
        default:
            break;
    }
}

#pragma mark Bullets

- (CGRect)battlefieldFrame {
    return CGRectMake(0, 0, 768, 1024);
}

- (BOOL)bulletOutOfBounds:(Bullet *)b {
    return !CGRectContainsPoint([self battlefieldFrame], b.l);
}

- (void)bulletPulse {
    NSMutableArray *bulletsToErase = [NSMutableArray array];
    for (Bullet *b in self.bullets) {
        [b pulse];
        if ([self bulletOutOfBounds:b]) {
            [bulletsToErase addObject:b];
        }
    }
    
    for (Bullet *b in bulletsToErase) {
        [b removeFromParentAndCleanup:YES];
    }
    
    [self.bullets removeObjectsInArray:bulletsToErase];
}

- (void)clonesPulse {
    for (QuantumClone *c in self.clones) {
        [c pulse];
    }
}

- (void)pulse {
    [self.currentState pulse];
    //states manage
    if ([self.currentState isPulsing]) {
        [self rhythmPulse];
        [self bulletPulse];
        [self.pilot pulse];
        [self clonesPulse];
    }
}

#pragma mark States

- (void)changeState:(QPBFState *)state {
    self.currentState = state;
}

- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l {
    [self changeState:state];
    [self.currentState addTouch:l];
}

#pragma mark Input

- (void)addTouch:(CGPoint)l {
    [self.currentState addTouch:l];
}

- (void)endTouch:(CGPoint)l {
    [self.currentState endTouch:l];
}

- (void)moveTouch:(CGPoint)l {
    [self.currentState moveTouch:l];
}

#pragma mark Pilot Positioning

- (BOOL)touchingPlayer:(CGPoint)l {
    return GetDistance(l, self.pilot.l) <= QPBF_PLAYER_TAP_RANGE;
}

- (CGPoint)playerTouchWithOffset {
    return CombinedPoint(self.playerTouch, self.touchOffset);
}

- (void)setTouchOffsetFromPilotNear:(CGPoint)l {
    self.touchOffset = ccp(self.pilot.l.x - l.x, self.pilot.l.y - l.y);
}

- (void)setTouchOffsetFromLatestExpectedNear:(CGPoint)l {
    self.touchOffset = ccp(self.latestExpected.x - l.x, self.latestExpected.y - l.y);
}

#pragma mark deltas

#pragma mark Pilot Delgate

- (void)pilotReachedEndOfFutureWaypoints {
    [self changeState:self.pausedState];
}

#pragma mark Bullet Delegate

- (void)bulletsFired:(NSArray *)bullets {
    [self.bullets addObjectsFromArray:bullets];
    for (Bullet *b in bullets) {
        [self addChild:b];
    }
}

#pragma mark Clones

- (void)setupClone {
    [self.pilot createClone];
    [self addChild:(CCNode *)self.pilot.clone];
    self.pilot.clone.l = CGPointMake(368, 500);
}

- (void)setupClones {
    self.clones = [NSMutableArray array];
    [self setupClone];
}

@end
