#import "QPBattlefield.h"
#import "Bullet.h"
#import "QuantumClone.h"
#import "Debris.h"

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
    [self setupSpeeds];
//    self.pilot.blinking = true;
}

- (void)setupStates {
    self.titleState = [[[QPBFTitleState alloc] initWithBattlefield:self] autorelease];
    self.drawingState = [[[QPBFDrawingState alloc] initWithBattlefield:self] autorelease];
    self.pausedState =  [[[QPBFPausedState alloc] initWithBattlefield:self] autorelease];
    self.fightingState = [[[QPBFFightingState alloc] initWithBattlefield:self] autorelease];
    self.scoreState = [[[QPBFScoreState alloc] initWithBattlefield:self] autorelease];
    self.recycleState = [[[QPBFRecycleState alloc] initWithBattlefield:self] autorelease];
    self.currentState = self.titleState;
}

- (void)setupDeadline {
    self.dl = [[[DeadLine alloc] init] autorelease];
    [self addChild:self.dl];
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
        [self setupDeadline];
        [self setupSpeeds];
        self.debris = [NSMutableArray array];
        level = 1;
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

- (void)processKill:(QuantumPilot *)c {
    hits++;
    Debris *d = [[Debris alloc] initWithL:c.l];
    [self addChild:d];
    [self.debris addObject:d];
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
                if (!p.active) {
                    [self processKill:p];
                }
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

- (void)eraseDebris {
    for (Debris *d in self.debris) {
        [self removeChild:d cleanup:YES];
    }
    
    [self.debris removeAllObjects];
}

- (void)resetPilot {
    [self.pilot engage];
}

- (void)resetBattlefield {
    level = 1;
    [self eraseBullets];
    [self eraseClones];
    [self eraseDebris];
    [self resetPilot];
    [self changeState:self.pausedState];
    [self setupClone];
    [self.dl reset];
    [self resetLevelScore];
    self.score = 0;
    [self setupSpeeds];
    weaponLevel = 0;
    installLevel = 0;
}

- (BOOL)debrisOutOfBounds:(Debris *)d {
    return !CGRectContainsPoint([self battlefieldFrame], d.l);
}


- (void)debrisPulse {
    NSMutableArray *debrisToErase = [NSMutableArray array];
    for (Debris *d in self.debris) {
        [d pulse];
        if ([self debrisOutOfBounds:d] || [self.pilot processDebris:d]) {
            [debrisToErase addObject:d];
        }
    }
    
    for (Debris *d in debrisToErase) {
        [d removeFromParentAndCleanup:YES];
    }
    
    [self.debris removeObjectsInArray:debrisToErase];
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

- (void)advanceLevel {
    
}

- (NSDictionary *)levelScore {
    float ab = 0;
    if (hits >= shotsFired) {
        ab = 100000;
    } else {
        float acc = (float)hits / (float)shotsFired;
        ab = floorf(acc * 10000);
    }
    
    NSNumber *accBonus = [NSNumber numberWithInteger:(int)floorf(ab)];
    NSNumber *timeBonus = [NSNumber numberWithInteger:self.dl.y * 10];
    NSLog(@"ab:%f, accBonus: %@", ab, accBonus);
    
    
    float pathing = 0;
    if (paths <= 1) {
        pathing = 100000;
    } else if (paths < level) {
        pathing = (float)paths / (float)level;
        pathing = fabsf(1-pathing);
        pathing *= 100000;
    }
    
    NSNumber *pathingBonus = [NSNumber numberWithFloat:pathing];
    NSNumber *currentScore = [NSNumber numberWithInteger:self.score];
    
    NSLog(@"currentScore: %d -- %d", [currentScore intValue], self.score);
    
    return @{QP_BF_TIMESCORE: timeBonus, QP_BF_ACCSCORE: accBonus, QP_BF_PATHSCORE: pathingBonus, QP_BF_SCORE: currentScore};
}

- (void)resetLevelScore {
    hits = 0;
    shotsFired = 0;
    paths = 1;
}

- (void)processWaveKill {
    [self.pilot resetPosition];
    QuantumClone *c = [[self.pilot clone] copy];
    c.bulletDelegate = self;
    c.weapon = self.pilot.weapon;
    [self.clones addObject:c];
    [self addChild:c];
    [self.clones removeObject:self.pilot.clone];
    [self removeChild:self.pilot.clone cleanup:YES];
    self.pilot.clone = nil;
    [self.pilot installWeapon];
    [self activateClones];
    [self setupClone];
    [self.pilot resetIterations];
    [self changeState:self.scoreState withOptions:[self levelScore]];
    [self resetLevelScore];
    [self eraseBullets];
    [self.dl reset];
    weaponLevel = 0;
    level++;
}

- (void)killPulse {
    if ([self activeClones] == 0) {
        [self processWaveKill];
    }
}

- (bool)isPulsing {
    return [self.currentState isPulsing];
}

- (void)moveDeadline {
    [self.dl pulse];
    if (self.dl.y < self.pilot.l.y) {
        [self resetBattlefield];
    }
}

- (void)pulse {
    [self.currentState pulse];
    //states manage
    [self rhythmPulse];
    if ([self isPulsing]) {
        [self.pilot pulse];
        [self clonesPulse];
        [self killPulse];
        [self bulletPulse];
        [self moveDeadline];
        [self debrisPulse];
    } else if (self.currentState == self.pausedState){
        
    }

}

#pragma mark States

- (void)changeState:(QPBFState *)state withOptions:(NSDictionary *)options {
    [self.currentState deactivate];
    self.currentState = state;
    [self.currentState activate:options];
    self.pilot.blinking = self.currentState == self.pausedState;
}

- (void)changeState:(QPBFState *)state {
    [self changeState:state withOptions:nil];
    
}

- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l {
    if (self.currentState == self.fightingState) {
        paths++;
    }
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
    paths++;

    [self changeState:self.pausedState];
}

#pragma mark Bullet Delegate

- (void)bulletsFired:(NSArray *)bullets {
    shotsFired++;
    NSLog(@"shotsFired: %d", shotsFired);
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

#pragma mark Speeds

- (void)setupSpeeds {
    float speed = 1.6 + ((arc4random() % 40) * .01);
    [self.pilot setSpeed:speed];
    [[Weapon w] setupSpeed];
    //return 2.5; //2.4 //phone: 3.91 //10, //ipad: 6.8
    //1.8 //phone: 2.3 //ipad: //old setting: 6.3
}

#pragma mark Recycling

- (bool)installShield {
    return false;
}

- (bool)installWarning {
    return false;
}

- (bool)installBomb {
    return false;
}

- (NSArray *)weaponDescriptions {
    return @[@"SIGMA", @"GAMMA"];
}

- (NSArray *)weapons {
    return @[@"FastLaserCannon", @"TightSplitLaserCannon"]; // @"WideTripleLaserCannon", @"TripleLaserCannon", @"QuadLaserCannon"];
}

- (NSString *)nextWeapon {
    if (weaponLevel < [[self weapons] count]) {
        return [self weapons][weaponLevel];
    }
    
    return nil;
}

- (bool)weaponMaxed {
    return weaponLevel >= [[self weapons] count];
}

- (int)nextWeaponCost {
    return (installLevel+1)* 10;
}

- (bool)canAffordNextWeapon {
    if ([self weaponMaxed]) {
        return false;
    }
    
    if (weaponLevel < installLevel) {
        return true;
    }
    
    return self.pilot.debris >= [self nextWeaponCost] && ![self weaponMaxed];
}

- (NSString *)nextWeaponDescription {
    return [self weaponDescriptions][weaponLevel];
}

- (void)recycleDebris:(int)d {
    self.pilot.debris -= d;
    [self.recycleState reloadDebris:self.pilot.debris];
}

- (bool)installNextWeapon {
    if ([self canAffordNextWeapon]) {
        
        [self.pilot installWeapon:[self nextWeapon]];
        weaponLevel++;
        if (weaponLevel > installLevel) {
            [self recycleDebris:[self nextWeaponCost]];
            installLevel++;
        }
        
        if ([self weaponMaxed]) {
            [self.recycleState showWeapon:@"GOOD LUCK!"];
        } else {
            [self.recycleState showWeapon:[self nextWeaponDescription]];
        }
        return true;
    }

    return false;
}

- (void)reloadDebrisDisplay {
    [self.recycleState reloadDebris:self.pilot.debris];
}

- (void)enterRecycleState {
    [self changeState:self.recycleState withOptions:@{QP_RECYCLE_NEXT_WEAPON : [self nextWeaponDescription]}];
    [self reloadDebrisDisplay];
}

@end
