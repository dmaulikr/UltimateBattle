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
        self.cloneBullets = [NSMutableArray array];
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

#pragma mark Pacing

- (void)historiesCleared {
    [self setupClone];
}

#pragma mark Bullets

- (CGRect)battlefieldFrame {
    return CGRectMake(0, 0, 768, 1024);
}

- (BOOL)bulletOutOfBounds:(Bullet *)b {
    return !CGRectContainsPoint([self battlefieldFrame], b.l);
}

- (void)eraseBullets {
    for (Bullet *b in self.bullets) {
        [self removeChild:b cleanup:YES];
    }
    for (Bullet *b in self.cloneBullets) {
        [self removeChild:b cleanup:YES];
    }
    [self.bullets removeAllObjects];
    [self.cloneBullets removeAllObjects];
}

- (void)pulseBullets:(NSMutableArray *)bs targets:(NSArray *)targets {
    NSMutableArray *bulletsToErase = [NSMutableArray array];
    for (Bullet *b in bs) {
        [b pulse];
        if ([self bulletOutOfBounds:b]) {
            [bulletsToErase addObject:b];
        }
    }
    
    for (Bullet *b in bs) {
        for (QuantumPilot *p in targets) {
            if (p.active) {
                [p processBullet:b];
            }
        }
    }
    
    for (Bullet *b in bulletsToErase) {
        [b removeFromParentAndCleanup:YES];
    }
    
    [bs removeObjectsInArray:bulletsToErase];
}

- (void)eraseClones {
    for (QuantumClone *c in self.clones) {
        [self removeChild:c cleanup:YES];
    }
    [self.clones removeAllObjects];
}

- (void)resetPilot {
    [self.pilot engage];
}

- (void)resetBattlefield {
    [self eraseBullets];
    [self eraseClones];
    [self resetPilot];
    [self changeState:self.pausedState];
    [self setupClone];
}

- (void)bulletPulse {
    [self pulseBullets:self.bullets targets:self.clones];
    [self pulseBullets:self.cloneBullets targets:@[self.pilot]];
    if (self.pilot.active == NO) {
        [self resetBattlefield];
    }
}

- (void)clonesPulse {
    for (QuantumClone *c in self.clones) {
        [c pulse];
    }
}

- (void)activateClones {
    for (QuantumClone *c in self.clones) {
        [c activate];
    }
}

- (void)killPulse {
    if ([self activeClones] == 0) {
        [self.pilot resetPosition];
        QuantumClone *c = [[self.pilot clone] copy];
        c.bulletDelegate = self;
        [self.clones addObject:c];
        [self addChild:c];
        [self.clones removeObject:self.pilot.clone];        
        [self removeChild:self.pilot.clone cleanup:YES];
        self.pilot.clone = nil;
        [self activateClones];
        [self setupClone];
        [self.pilot resetIterations];
        [self changeState:self.pausedState];
        [self eraseBullets];
    }
}

- (void)pulse {
    [self.currentState pulse];
    //states manage
    if ([self.currentState isPulsing]) {
        [self rhythmPulse];
        [self.pilot pulse];
        [self clonesPulse];
        [self killPulse];
        [self bulletPulse];
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

- (void)addDoubleTouch {
    [self.currentState addDoubleTouch];
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

- (void)cloneBulletsFired:(NSArray *)bullets {
    [self.cloneBullets addObjectsFromArray:bullets];
    for (Bullet *b in bullets) {
        [self addChild:b];
    }
}

#pragma mark Clones

- (void)setupClone {
    [self.pilot createClone];
    [self.clones addObject:self.pilot.clone];
    [self addChild:(CCNode *)self.pilot.clone];
}

- (NSInteger)activeClones {
    NSInteger active = 0;
    for (QuantumClone *c in self.clones) {
        active += c.active ? 1 : 0;
    }
    return active;
}

- (void)setupClones {
    self.clones = [NSMutableArray array];
    [self setupClone];
}

@end
