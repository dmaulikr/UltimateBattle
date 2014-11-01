#import "QPBattlefield.h"
#import "Bullet.h"
#import "QuantumClone.h"
#import "Debris.h"
#import "WideTriLaserCannon.h"
#import "WideSpiralLaserCannon.h"
#import "QuadLaserCannon.h"
#import "Arsenal.h"
#import "Shatter.h"

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
}

- (void)setupStates {
    self.titleState = [[[QPBFTitleState alloc] initWithBattlefield:self] autorelease];
    self.drawingState = [[[QPBFDrawingState alloc] initWithBattlefield:self] autorelease];
    self.pausedState =  [[[QPBFPausedState alloc] initWithBattlefield:self] autorelease];
    self.fightingState = [[[QPBFFightingState alloc] initWithBattlefield:self] autorelease];
    self.scoreState = [[[QPBFScoreState alloc] initWithBattlefield:self] autorelease];
    self.recycleState = [[[QPBFRecycleState alloc] initWithBattlefield:self] autorelease];
    [self changeState:self.titleState];
}

- (void)setupDeadline {
    self.dl = [[[DeadLine alloc] init] autorelease];
    [self addChild:self.dl];
}

- (void)setupWeapons {
    self.weapons = [Arsenal upgradeArsenal];
}

- (NSString *)activePath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"qp_active_skill"];
}

- (void)loadSounds {
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"dismantler" ofType:@"m4a"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &dismantler);
    
    path  = [[NSBundle mainBundle] pathForResource:@"corecrusher" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &corecrusher);
    
    path  = [[NSBundle mainBundle] pathForResource:@"novasplitter" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &novasplitter);
    
    path  = [[NSBundle mainBundle] pathForResource:@"exoslicer" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &exoslicer);
    
    path  = [[NSBundle mainBundle] pathForResource:@"spacemelter" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &spacemelter);
    path  = [[NSBundle mainBundle] pathForResource:@"gammahammer" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &gammahammer);
    path  = [[NSBundle mainBundle] pathForResource:@"voidwave" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &voidwave);
}

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
        self.cloneBullets = [NSMutableArray array];
        self.debris = [NSMutableArray array];
        self.shieldDebris = [NSMutableArray array];
        self.shatters = [NSMutableArray array];
        [self setupPulses];
        [self setupPilot];
        [self setupStates];
        [self setupClones];
        [self setupDeadline];
        [self setupSpeeds];
        [self setupWeapons];
        [self loadSounds];
        self.scoreCycler = [[[QPScoreCycler alloc] init] autorelease];
     
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDebrisShow) name:@"DebrisCollected" object:nil];
        level = 1;
        
        [self showGuide:0 wave:1];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self activePath]]) {
            self.activeScores = [NSMutableArray arrayWithContentsOfFile:[self activePath]];
        } else {
            self.activeScores = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                [self.activeScores addObject:@"0"];
            }
        }
    }
    return self;
}

- (void)showGuide:(int)guideLevel wave:(bool)wave {
    float height = [[UIScreen mainScreen] bounds].size.height;
    if (veteran) {
        NSString *text = [NSString stringWithFormat:@"Wave %d", level];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Guide" object:@{@"x":[NSNumber numberWithInteger:self.pilot.l.x], @"y" : [NSNumber numberWithInteger:(height - self.pilot.l.y + 35)], @"text" : text}];
        return;
    }
    
    NSString *text = nil;
    NSString *g2Text = nil;
    
    if (wave) {
        text = [NSString stringWithFormat:@"Wave %d\nDrag your ship to record a path", level];
        g2Text = [NSString stringWithFormat:@"Wave %d\nTap anywhere else to fire", level];
    } else {
        text = @"Drag your ship to record a path";
        g2Text = @"Tap anywhere else to fire";
    }
    
    switch (guideLevel) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Guide" object:@{@"x":[NSNumber numberWithInteger:self.pilot.l.x], @"y" : [NSNumber numberWithInteger:(height - self.pilot.l.y + 35)], @"text" : text}];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Guide" object:@{@"x":[NSNumber numberWithFloat:self.pilot.l.x], @"y" : [NSNumber numberWithInteger:(height - self.pilot.l.y + 75)], @"text" : g2Text}];
            break;
        default:
            break;
    }
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
    return CGRectMake(-100, -100, 768 + 100, 1024 + 100);
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

- (void)createDebrisFromCloneKill:(QuantumClone *)c bullet:(Bullet *)b {
//    if (self.clones.lastObject == c) {
//        return;
//    }
    
    
    Debris *d = [[[Debris alloc] initWithL:c.l] autorelease];
    [d assignLevel];
    [self addChild:d];
    [self.debris addObject:d];
    
    Shatter *s = [[[Shatter alloc] initWithL:c.l weapon:[b weapon]] autorelease];
    [self.shatters addObject:s];
    [self addChild:s];
}

- (void)processKill:(QuantumPilot *)c bullet:(Bullet *)b {
    if (c != self.pilot) {
        hits++;
        [self createDebrisFromCloneKill:(QuantumClone *)c bullet:b];
    }

    [self registerShieldHit:c weapon:c.weapon];
}

- (void)pulseBullets:(NSMutableArray *)bs targets:(NSArray *)targets {
    for (Bullet *b in bs) {
        for (QuantumPilot *p in targets) {
            if (p.active) {
                if (fabsf(p.l.x - b.l.x) + fabsf(p.l.y - b.l.y) < 50) {
                    if ([p processBullet:b]) {
                        [self processKill:p bullet:b];
                    }
                }
            }
        }
    }
    
    NSMutableArray *bulletsToErase = [NSMutableArray array];
    for (Bullet *b in bs) {
        [b pulse];
        if ([self bulletOutOfBounds:b]) {
            [bulletsToErase addObject:b];
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

- (NSString *)activeScore {
    int as = 0;
    for (int i = 0; i < 10; i++) {
        as+= [self.activeScores[i] intValue];
    }
    
    return [NSString stringWithFormat:@"Rating\n%d", as];
}

- (void)resetBattlefield {
    veteran = level > 4;
    level = 1;
    [self.scoreCycler reset];
    [self eraseBullets];
    [self eraseClones];
    [self eraseDebris];
    [self resetPilot];
    [self changeState:self.titleState];
    [self setupClone];
    [self.dl reset];
    [self resetLevelScore];
    [self.activeScores removeObjectAtIndex:0];
    [self.activeScores addObject:[NSString stringWithFormat:@"%d", self.score]];
    [self.activeScores writeToFile:[self activePath] atomically:true];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubtitleLabel" object:@{@"x" : @"160", @"y" : @"88", @"text" : [self activeScore]}];
    self.score = 0;
    [self setupSpeeds];
    weaponLevel = 0;
    installLevel = 0;
    warning = 0;
    slow = 0;
    
    [self showGuide:0 wave:1];
}

- (BOOL)debrisOutOfBounds:(Debris *)d {
    return !CGRectContainsPoint([self battlefieldFrame], d.l) || [d dissipated];
}


- (void)debrisPulse {
    NSMutableArray *debrisToErase = [NSMutableArray array];
    for (Debris *d in self.debris) {
        [d pulse];

        if ([self debrisOutOfBounds:d]) {
            [debrisToErase addObject:d];         
        } else if ([self.pilot processDebris:d]) {
            switch (d.level) {
                case 0:
                    AudioServicesPlaySystemSound(dismantler);
                    break;
                case 1:
                    AudioServicesPlaySystemSound(novasplitter);
                    break;
                case 2:
                    AudioServicesPlaySystemSound(corecrusher);
                    break;
                case 3:
                    AudioServicesPlaySystemSound(exoslicer);
                    break;
                case 4:
                    AudioServicesPlaySystemSound(gammahammer);
                    break;
                case 5:
                    AudioServicesPlaySystemSound(spacemelter);
                    break;
                case 6:
                    AudioServicesPlaySystemSound(voidwave);
                    break;
                    
                default:
                    break;
            }
            

            [self.scoreCycler score:100];
            [debrisToErase addObject:d];
            [self resetDebrisShow];
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
        if (warning) {
            [c showFireSignal];
        }
        [c pulse];
    }
}

- (void)activateClones {
    for (QuantumClone *c in self.clones) {
        [c activate];
    }
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
    
    float pathing = 0;
    if (paths <= 1) {
        pathing = 100000;
    } else if (paths < level) {
        pathing = (float)(paths - 1) / (float)level;
        pathing = fabsf(1-pathing);
        pathing *= 100000;
    }
    
    NSNumber *pathingBonus = [NSNumber numberWithFloat:pathing];
    NSNumber *currentScore = [NSNumber numberWithInteger:self.score];
    
    return @{QP_BF_TIMESCORE: timeBonus, QP_BF_ACCSCORE: accBonus, QP_BF_PATHSCORE: pathingBonus, QP_BF_SCORE: currentScore};
}

- (void)resetLevelScore {
    hits = 0;
    shotsFired = 0;
    paths = 1;
}

- (void)showWinBlast {
    [self registerShieldHit:self.pilot weapon:self.pilot.weapon];
}

- (void)processWaveKill {
    [self showWinBlast];
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
    [self.scoreCycler addScoring:[self levelScore]];
    self.score = [self.scoreCycler actualScore];
    [self changeState:self.pausedState];
    [self resetLevelScore];
    [self eraseBullets];
    [self.dl reset];
    weaponLevel = 0;
    level++;
    
    [self showGuide:0 wave:1];
    
    warning = 0;
    slow = 0;
    
    for (QuantumClone *c in self.clones) {
        c.showPath = false;
    }
    
    int i = self.clones.count - 2;
    QuantumClone *pc = self.clones[i];
    pc.showPath = true;
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
    if (!slow) {
        [self.dl pulse];
    } else {
        slow--;
    }
    
    if (self.dl.y < self.pilot.l.y) {
        [self registerShieldHit:self.pilot weapon:@"DeadLine"];
        [self resetBattlefield];
    }

}

- (void)shieldDebrisPulse {
    NSMutableArray *debrisToErase = [NSMutableArray array];
    for (ShieldDebris *d in self.shieldDebris) {
        [d pulse];
        
        if ([self debrisOutOfBounds:d]) {
            [debrisToErase addObject:d];
        }
    }
    
    for (ShieldDebris *d in debrisToErase) {
        [d removeFromParentAndCleanup:YES];
    }
    
    [self.shieldDebris removeObjectsInArray:debrisToErase];

}

- (void)shatterPulse {
    NSMutableArray *shattersToErase = [NSMutableArray array];
    for (Shatter *s in self.shatters) {
        [s pulse];
        if ([s dissipated]) {
            [shattersToErase addObject:s];
        }
    }
    
    for (Shatter *s in shattersToErase) {
        [self removeChild:s cleanup:true];
    }
    
    [self.shatters removeObjectsInArray:shattersToErase];
}

- (void)calculateCircleCharges {
    _circleCharges = [self.pilot weaponLevel];
}

- (void)pulse {
    [self calculateCircleCharges];
    
    [self.currentState pulse];
    //states manage
    
//    [self titlePulse];
    
    [self rhythmPulse];
    [self shieldDebrisPulse];
    [self shatterPulse];
    
    if ([self isPulsing]) {
        [self debrisPulse];
        [self.pilot pulse];
        [self clonesPulse];
        [self killPulse];
        [self bulletPulse];
        [self moveDeadline];
        [self scorePulse];
    } else { //if (self.currentState == self.pausedState) {
        [self.pilot defineEdges];
        [self.pilot prepareDeltaDraw];
        for (QuantumClone *c in self.clones) {
            [c defineEdges];
        }
        
        if (self.currentState == self.titleState) {
            NSString *autofireAlert = [NSString stringWithFormat:@"Autofire: %@", self.pilot.autofire ? @"ON" : @"OFF"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ScoreLabel" object:autofireAlert];
        } else {
            [self scorePulse];
        }
    }
    
    [self debrisShowPulse];
}

- (void)scorePulse {
    [self.scoreCycler pulse];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScoreLabel" object:[NSString stringWithFormat:@"%d", [self.scoreCycler displayedScore]]];
}

- (void)debrisShowPulse {
    if (debrisShow > 0) {
        if (self.currentState != self.recycleState) {
            debrisShow--;
        }
        
        if (debrisShow == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DebrisLabel" object:@{@"x":[NSNumber numberWithInteger:0], @"y" : [NSNumber numberWithInteger:0], @"text" : @""}];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DebrisLabel" object:@{@"x":[NSNumber numberWithInteger:self.pilot.l.x], @"y" : [NSNumber numberWithInteger:self.pilot.l.y - 10], @"text" : [NSString stringWithFormat:@"%d", self.pilot.debris]}];

        }
    }
}

#pragma mark States

- (void)changeState:(QPBFState *)state withOptions:(NSDictionary *)options {
    if (self.currentState) {
        [self.currentState deactivate];
        
        if (self.currentState == self.titleState) {
            titleSlide = true;
            titleDelay = 225;
            titleY = 50;
        } else if (state == self.drawingState) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clearLabels" object:nil];
        } else if (state == self.pausedState) {
            [self showGuide:0 wave:1];
        } else if (state == self.fightingState && !veteran && level < 4) {
            [self showGuide:1 wave:0];
        }
    }
    
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
    if (!veteran) {
        [self showGuide:0 wave:0];
    }
}

#pragma mark Bullet Delegate

- (void)bulletsFired:(NSArray *)bullets {
    shotsFired++;
    
    for (Bullet *b in bullets) {
        [self addChild:b];
    }
    
    [self.bullets addObjectsFromArray:bullets];
    
    [self.scoreCycler score:1];
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

- (int)shieldCost {
    return (self.pilot.shield + 1) * 50;
}

- (bool)canAffordShield {
    return self.pilot.debris >= [self shieldCost];
}

- (int)maxShield {
    return 9;
}

- (bool)shieldMaxed {
    return self.pilot.shield >= [self maxShield];
}

- (bool)installShield {
    if (self.pilot.shield < [self maxShield] && [self canAffordShield]) {
        [self recycleDebris:[self shieldCost]];
        [self.pilot installShield];
        return true;
    }
    
    return false;
}
            
- (int)warningCost {
    return (level - 1);
}

- (bool)canAffordWarning {
    return self.pilot.debris >= [self warningCost];
}

- (bool)installWarning {
    if (!warning && [self canAffordWarning]) {
        [self recycleDebris:[self warningCost]];
        warning = 1;
        [self reloadWarningDisplay];
        return true;
    }
    
    return false;
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
    if ([self underpowered]) {
        return 0;
    }
    return (installLevel+1)* 50; //50
}

- (bool)underpowered {
    return weaponLevel < installLevel;
}

- (bool)canAffordNextWeapon {
    if ([self weaponMaxed]) {
        return false;
    }
    
    if ([self underpowered]) {
        return true;
    }
    
    return self.pilot.debris >= [self nextWeaponCost] && ![self weaponMaxed];
}

- (void)recycleDebris:(int)d {
    self.pilot.debris -= d;
    [self.recycleState reloadDebris:self.pilot.debris];
}

- (bool)installNextWeapon {
    if ([self canAffordNextWeapon]) {
        [self.pilot installWeapon:[self nextWeapon]];
        [self showWinBlast];
        weaponLevel++;
        if (weaponLevel > installLevel) {
            [self recycleDebris:[self nextWeaponCost]];
            installLevel++;
        }
        
        if ([self weaponMaxed]) {
            [self.recycleState showWeapon:@"GOOD LUCK!"];
        } else {
            [self.recycleState showWeapon:[self nextWeapon] cost:[self nextWeaponCost]];
        }
        return true;
    }

    return false;
}

- (int)slowCost {
    return (level - 1);
}

- (bool)canAffordSlow {
    return !slow && self.pilot.debris > [self slowCost];
}

- (int)slowInstallLevel {
    return 1000;
}

- (bool)installSlow {
    if ([self canAffordSlow]) {
        [self recycleDebris:[self slowCost]];
        slow = [self slowInstallLevel];
        [self.recycleState showSlow:slow];
    }
    
    return false;
}

- (void)resetDebrisShow {
    debrisShow = 115;
}

- (void)reloadDebrisDisplay {
    [self.recycleState reloadDebris:self.pilot.debris];
    [self resetDebrisShow];
}

- (void)reloadWarningDisplay {
    [self.recycleState showWarningActivated:warning];
}

- (void)finishedDisplayingScore:(CGPoint)l rush:(bool)rush {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearLabels" object:nil];
    if (rush) {
        [self changeState:self.pausedState withTouch:l];
    } else {
        if (self.pilot.debris >= 50) {
            [self enterRecycleState:true];
        } else {
            [self enterRecycleState:false];
        }
    }
}

- (void)enterRecycleState:(bool)show {
    NSNumber *cost = [NSNumber numberWithInt:[self nextWeaponCost]];
    if (show) {
        [self changeState:self.recycleState withOptions:@{QP_RECYCLE_NEXT_WEAPON : [self nextWeapon],
                                                          QP_RECYCLE_NEXT_WEAPON_COST : cost}];
        [self reloadDebrisDisplay];
        [self reloadWarningDisplay];
    } else {
        [self changeState:self.recycleState withOptions:@{QP_RECYCLE_NEXT_WEAPON : @"cancel"}];
    }
}

#pragma mark Pilot effects

- (void)registerShieldHit:(QuantumPilot *)p weapon:(NSString *)w {
//    ShieldDebris *d = [[[ShieldDebris alloc] init] autorelease];
//    d.l = p.l;
//    d.pilot = p;
//    [d setWeapon:w];
//    if (self.clones.lastObject == p) {
//        [d setWeapon:[Arsenal arsenal][0]];
//    }
//    [self.shieldDebris addObject:d];
//    [self addChild:d];
}

- (void)registerShieldHit:(QuantumPilot *)p {
    [self registerShieldHit:p weapon:nil];
}

- (void)draw {
    [super draw];
    
    [[Arsenal weaponIndexedFromArsenal:[self.pilot arsenalLevel]] setDrawColor];
    
    int x = 3;
    for (int i = 0; i < _circleCharges + 1; i++) {
        CGPoint c = ccp(x, 568 - 540);
        ccDrawFilledCircle(c, 1.7, 0, 30, NO);
        x+=6;
    }
}

- (float)bulletSpeed {
    return 2.2 + (min((float)_circleCharges, (float)6) * .40 ) ;
}

@end
