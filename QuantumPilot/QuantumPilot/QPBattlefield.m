#import "QPBattlefield.h"
#import "Bullet.h"

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

- (void)bulletPulse {
    for (Bullet *b in self.bullets) {
        [b pulse];
    }
}

- (void)pulse {
    [self.currentState pulse];
    //states manage
    if ([self.currentState isPulsing]) {
        [self rhythmPulse];
        [self bulletPulse];
        [self.pilot pulse];
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

@end
