#import "QPBattlefield.h"
#import "Bullet.h"
#import "QuantumClone.h"
#import "Debris.h"
#import "WideTriLaserCannon.h"
#import "WideSpiralLaserCannon.h"
#import "QuadLaserCannon.h"
#import "Arsenal.h"
#import "Shatter.h"
#import "FastLaser.h"

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
    [self changeState:self.titleState];
    [self resetLineXDirection:0];
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

    path  = [[NSBundle mainBundle] pathForResource:@"voidwave" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &voidwave);

    path  = [[NSBundle mainBundle] pathForResource:@"l1-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l1);

    path  = [[NSBundle mainBundle] pathForResource:@"l2-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l2);

    
    path  = [[NSBundle mainBundle] pathForResource:@"l3-22" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l3);

    
    path  = [[NSBundle mainBundle] pathForResource:@"l4" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l4);

    path  = [[NSBundle mainBundle] pathForResource:@"l5-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l5);

    
    path  = [[NSBundle mainBundle] pathForResource:@"l6-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l6);

    
    path  = [[NSBundle mainBundle] pathForResource:@"l7-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &l7);

    path  = [[NSBundle mainBundle] pathForResource:@"collect-8" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &collect);

    path  = [[NSBundle mainBundle] pathForResource:@"x1-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x1);

    path  = [[NSBundle mainBundle] pathForResource:@"x2-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x2);
    
    path  = [[NSBundle mainBundle] pathForResource:@"x3-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x3);
    path  = [[NSBundle mainBundle] pathForResource:@"x4-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x4);
    path  = [[NSBundle mainBundle] pathForResource:@"x5-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x5);
    path  = [[NSBundle mainBundle] pathForResource:@"x6-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x6);
    path  = [[NSBundle mainBundle] pathForResource:@"x7-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &x7);
    
    path  = [[NSBundle mainBundle] pathForResource:@"process-12" ofType:@"wav"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &process);

    path  = [[NSBundle mainBundle] pathForResource:@"drag" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &drag);
    
    path  = [[NSBundle mainBundle] pathForResource:@"tap" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &tap);
    
    path  = [[NSBundle mainBundle] pathForResource:@"copy" ofType:@"m4a"];
    pathURL = [NSURL fileURLWithPath : path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &copy);

}

- (void)createSound:(NSString *)s systemSoundID:(SystemSoundID)ssid format:(NSString *)f{
    NSString *path = [[NSBundle mainBundle] pathForResource:s ofType:f];
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &ssid);
}

- (void)setupZones {
    self.zones = [NSMutableArray array];
    self.cloneZones = [NSMutableArray array];
    
    zonesWide = (int)(ceilf(_battlefieldFrame.size.width / (50.0f)));
    zonesTall = (int)(ceilf(_battlefieldFrame.size.height / (50.0f)));
    
    for (int i = 0; i < zonesTall; i++) {
        NSMutableArray *zs = [NSMutableArray array];
        for (int ii = 0; ii < zonesWide; ii++) {
            NSMutableArray *z = [NSMutableArray array];
            [zs addObject:z];
        }
        [self.zones addObject:zs];
    }
    
    for (int i = 0; i < zonesTall; i++) {
        NSMutableArray *zs = [NSMutableArray array];
        for (int ii = 0; ii < zonesWide; ii++) {
            NSMutableArray *z = [NSMutableArray array];
            [zs addObject:z];
        }
        [self.cloneZones addObject:zs];
    }
    
    NSLog(@"wide, tall, size, count, count[0]: %d, %d, %d %d", zonesWide, zonesTall, self.zones.count, [self.zones[0] count]);
}

- (id)init {
    self = [super init];
    if (self) {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        _battlefieldFrame = CGRectMake(bounds.origin.x - 10, bounds.origin.y - 10, bounds.size.width + 10, bounds.size.height + 10);
        _screenSize = bounds.size;
        self.bullets = [NSMutableArray array];
        self.cloneBullets = [NSMutableArray array];

        [self setupZones];
        
        self.debris = [NSMutableArray array];
        self.shieldDebris = [NSMutableArray array];
        self.shatters = [NSMutableArray array];
        [self setupPulses];
        [self setupPilot];
        [self setupStates];
        [self setupClones];
        l1y = self.pilot.l.y - 20;
        l2y = [self.clones[0] l].y + 20;
        l3y = l1y - 90;
        l3x = _battlefieldFrame.size.width * 2/3;
        l4x =_battlefieldFrame.size.width * 1/3;
        l3h = 0;
        [self setupDeadline];
        [self setupSpeeds];
        [self setupWeapons];
        [self loadSounds];
        self.scoreCycler = [[[QPScoreCycler alloc] init] autorelease];
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processBulletMoved:)
                                                     name:@"BulletMoved"
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processCloneBulletMoved:)
                                                     name:@"CloneBulletMoved"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showScores)
                                                     name:@"ShowScores"
                                                   object:nil];

        
        _screenSize = [[UIScreen mainScreen] bounds].size;
        
        level = 1;
        drawRadius = 10;
        fireCircle = [self fireCircleReset];
        
        [self setupDebrisCores];
        [self updateBottomCoreLabel];
        
        [self setupLeaderboard];
    }
    return self;
}

- (void)setupLeaderboard {
    CGSize size = [[UIScreen mainScreen] bounds].size;

    float segment = 10;
    float y = .73 * size.height;
    _leaderboardPoints[0] = ccp(.76 * size.width, y);
    _leaderboardPoints[1] = ccp(_leaderboardPoints[0].x, _leaderboardPoints[0].y + (2 * segment));
    _leaderboardPoints[2] = ccp(_leaderboardPoints[1].x + segment, _leaderboardPoints[1].y);
    _leaderboardPoints[3] = ccp(_leaderboardPoints[2].x, _leaderboardPoints[2].y - (2 * segment));
    _leaderboardPoints[4] = ccp(_leaderboardPoints[3].x, _leaderboardPoints[3].y + (3 * segment));
    _leaderboardPoints[5] = ccp(_leaderboardPoints[4].x + segment, _leaderboardPoints[4].y);
    _leaderboardPoints[6] = ccp(_leaderboardPoints[5].x, _leaderboardPoints[5].y - (3 * segment));
    _leaderboardPoints[7] = ccp(_leaderboardPoints[6].x, _leaderboardPoints[6].y + segment);
    _leaderboardPoints[8] = ccp(_leaderboardPoints[7].x + segment, _leaderboardPoints[7].y);
    _leaderboardPoints[9] = ccp(_leaderboardPoints[8].x, _leaderboardPoints[7].y - segment);
}

- (void)updateBottomCoreLabel {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeedLabel" object:[NSString stringWithFormat:@"%d◊", _coreCycles]];
}

- (void)setupDebrisCores {
    NSNumber *cores = [[NSUserDefaults standardUserDefaults] objectForKey:@"cores"];
    if (cores) {
        _coresCollected = [cores intValue];
    }
    
    NSNumber *coreCycles = [[NSUserDefaults standardUserDefaults] objectForKey:@"corecycles"];
    if (coreCycles) {
        _coreCycles = [coreCycles intValue];
    }
    
    _coreCycles = 25;
}

- (CGPoint)fireCircleReset {
    return ccp([[UIScreen mainScreen] bounds].size.width / 2, 28);
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

- (BOOL)bulletOutOfBounds:(Bullet *)b {
    return !CGRectContainsPoint(_battlefieldFrame, b.l);
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
    [self setupZones];
}

- (void)createDebrisFromCloneKill:(QuantumClone *)c bullet:(Bullet *)b {
//    if (self.clones.lastObject == c) {
//        return;
//    }
    
    Debris *d = [[[Debris alloc] initWithL:c.l] autorelease];
    [d multiplySpeed:[self speedMod]];
    [d assignLevel];
    [self addChild:d];
    [self.debris addObject:d];
    
    Shatter *s = [[[Shatter alloc] initWithL:c.l weapon:[b weapon]] autorelease];
    [self.shatters addObject:s];
    [self addChild:s];
}

- (void)playKillSound {
    int x = arc4random() % 7;
    
    switch (x) {
        case 0:
            AudioServicesPlaySystemSound(x1);
            break;
        case 1:
            AudioServicesPlaySystemSound(x2);
            break;
        case 2:
            AudioServicesPlaySystemSound(x3);
            break;
        case 3:
            AudioServicesPlaySystemSound(x4);
            break;
        case 4:
            AudioServicesPlaySystemSound(x5);
            break;
        case 5:
            AudioServicesPlaySystemSound(x6);
            break;
        case 6:
            AudioServicesPlaySystemSound(x7);
            break;
            
        default:
            break;
    }
}

- (void)processKill:(QuantumPilot *)c bullet:(Bullet *)b {
    [self playKillSound];
    if (c != self.pilot) {
        hits++;
        totalHits++;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KillsLabel" object:@{@"kills" : [NSNumber numberWithInt:totalHits], @"x" : [NSNumber numberWithFloat:c.l.x], @"y" : [NSNumber numberWithFloat:_battlefieldFrame.size.height - (-45 + c.l.y + 45)]}];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"KillsPulse" object:nil];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyPulse" object:nil];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScorePulse" object:nil];
        [self.scoreCycler score:(10000 * hits)];
        [self createDebrisFromCloneKill:(QuantumClone *)c bullet:b];
    }
}

- (void)pulseBullets:(NSMutableArray *)bs {
    NSMutableArray *bulletsToErase = [NSMutableArray array];
    for (Bullet *b in bs) {
        [b pulse];
        if ([self bulletOutOfBounds:b]) {
            shotsFired++;
            totalShotsFired++;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyPulse" object:nil];
            [bulletsToErase addObject:b];
        }
    }
    
    for (Bullet *b in bulletsToErase) {
        if (![self bulletOutOfBounds:b]) {
            NSMutableArray *a = self.zones[b.zy][b.zx];
            [a removeObject:b];
        }
        [b removeFromParentAndCleanup:YES];
    }
    
    [bs removeObjectsInArray:bulletsToErase];
}

- (void)pulseCloneBullets:(NSMutableArray *)bs {
    NSMutableArray *bulletsToErase = [NSMutableArray array];
    for (Bullet *b in bs) {
        [b pulse];
        if ([self bulletOutOfBounds:b]) {
            [bulletsToErase addObject:b];
        }
    }
    
    for (Bullet *b in bulletsToErase) {
        if (![self bulletOutOfBounds:b]) {
            NSMutableArray *a = self.cloneZones[b.zy][b.zx];
            [a removeObject:b];
        }
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

- (int)accuracy {
    if (totalHits >= totalShotsFired) {
        return 100;
    }
    int acc = (int)ceil((((float)totalHits / (float)totalShotsFired)) * 100.0);
    if (acc > 100) {
        acc = 100;
    }
    
    return acc;
}

- (void)announceAccuracy {
    NSNumber *accAnnouncement;
    if (totalShotsFired > 0) {
        int acc = [self accuracy];
        accAnnouncement = [NSNumber numberWithInteger:-1 * acc];
    } else {
        accAnnouncement = [NSNumber numberWithInteger:0];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyLabel" object:@{@"accuracy" : [accAnnouncement stringValue], @"corner" : [NSNumber numberWithBool:false]}];
}

- (void)showScores {
//    if ([self showSocial]) {
        NSString *laserText = [NSString stringWithFormat:@"%d\n¤", abs(totalHits)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LaserLabel" object:laserText];
        
        NSString *pathsText = [NSString stringWithFormat:@"%d\nζ", abs(totalPaths)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BoostLabel" object:pathsText];
        
        NSString *waveText = [NSString stringWithFormat:@"%d\n%%", abs([self accuracy])];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WaveLabel" object:waveText];
        
    //    [self announceAccuracy];
  //  }
}

- (void)resetBattlefield {
    veteran = level > 4;
    _guideMode = veteran ? _guideMode : circle;
    level = 1;
    if (_coresCollected > 20) {
        _coresCollected = 0;
        _coreCycles++;
    }
    NSNumber *cores = [NSNumber numberWithInteger:_coresCollected];
    [[NSUserDefaults standardUserDefaults] setObject:cores forKey:@"cores"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSNumber *coreCycles  = [NSNumber numberWithInteger:_coreCycles];
    [[NSUserDefaults standardUserDefaults] setObject:coreCycles forKey:@"corecycles"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    lastScore = [self.scoreCycler actualScore];
    [self.scoreCycler reset];
    
    [self showScores];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScorePulse" object:nil];
    
    [self eraseBullets];
    [self eraseClones];
    [self eraseDebris];
    [self resetPilot];
    self.pilot.l = ccp(5000, -5000);
    [self changeState:self.titleState];
    [self setupClone];
    [self.dl reset];
    [self resetLevelScore];
    
    self.score = 0;
    [self setupSpeeds];
    weaponLevel = 0;
    installLevel = 0;
    warning = 0;
    slow = 0;
    
    _playedDrag = 0;
    [self updateBottomCoreLabel];
}

- (BOOL)debrisOutOfBounds:(Debris *)d {
    return !CGRectContainsPoint(_battlefieldFrame, d.l) || [d dissipated];
}


- (void)debrisPulse {
    NSMutableArray *debrisToErase = [NSMutableArray array];
    for (Debris *d in self.debris) {
        [d pulse];

        if ([self debrisOutOfBounds:d]) {
            [debrisToErase addObject:d];         
        } else if ([self.pilot processDebris:d]) {
            AudioServicesPlaySystemSound(collect);
            
            _coresCollected++;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponPulse" object:nil];
            
            if (self.pilot.weaponLevel != d.level) {
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
            }
            [self.pilot announceWeapon];

            [self.scoreCycler score:100];
            [debrisToErase addObject:d];
        }
    }
    
    for (Debris *d in debrisToErase) {
        [d removeFromParentAndCleanup:YES];
    }
    
    [self.debris removeObjectsInArray:debrisToErase];
}

- (void)processPilotBulletsForZone:(NSMutableArray *)a forClone:(QuantumClone *)c {
    NSMutableArray *bulletsToRemove = [NSMutableArray array];
    for (Bullet *b in a) {
        if (ccpDistance(b.l, c.l) < 70 && [c processBullet:b]) {
            [self processKill:c bullet:b];
            [bulletsToRemove addObject:b];
        }
    }
    [a removeObjectsInArray:bulletsToRemove];
}

- (void)processPilotBullets {
    for (QuantumClone *c in self.clones) {
        if (c.active) {
            [self processPilotBulletsForZone:self.zones[c.zy][c.zx] forClone:c];
            
            bool greaterZeroX = c.zx > 0;
            bool greaterZeroY = c.zy > 0;
            bool lessMaxX = c.zx < zonesWide - 1;
            bool lessMaxY = c.zy < zonesTall - 1;
            if (greaterZeroX) {
                [self processPilotBulletsForZone:self.zones[c.zy][c.zx-1] forClone:c];
                if (greaterZeroY) {
                    [self processPilotBulletsForZone:self.zones[c.zy-1][c.zx-1] forClone:c];
                } else if (lessMaxY) {
                    [self processPilotBulletsForZone:self.zones[c.zy+1][c.zx-1] forClone:c];
                }
            } else if (lessMaxX) {
                [self processPilotBulletsForZone:self.zones[c.zy][c.zx+1] forClone:c];
                if (greaterZeroY) {
                    [self processPilotBulletsForZone:self.zones[c.zy-1][c.zx+1] forClone:c];
                } else if (lessMaxY) {
                    [self processPilotBulletsForZone:self.zones[c.zy+1][c.zx+1] forClone:c];
                }
            }
            
            if (lessMaxX) {
                [self processPilotBulletsForZone:self.zones[c.zy][c.zx+1] forClone:c];
            } else if (lessMaxY) {
                [self processPilotBulletsForZone:self.zones[c.zy+1][c.zx] forClone:c];
            }
        }
    }
    
    
    
    for (Bullet *b in self.bullets) {
        if (b.crushes > 0) {
            NSMutableArray *a = self.cloneZones[b.zy][b.zx];
                for (Bullet *bb in a) {
                    if (ccpDistance(b.l, bb.l) < 4) {
                        [b crushBullet:bb];
                        hits++;
//                        totalHits++;
                    }
                }
        }
    }
}

- (bool)bulletCrushes:(Bullet *)b {
    return b.class == [FastLaser class];
}

- (void)processCloneBulletsInZone:(NSMutableArray *)a {
    NSMutableArray *bulletsToRemove = [NSMutableArray array];
    for (Bullet *b in a) {
        if (ccpDistance(b.l, self.pilot.l) < 70 && [self.pilot processBullet:b]) { //opportunity for dodge notation
            [self playKillSound];
            [bulletsToRemove addObject:b];
        }
    }
    
    [a removeObjectsInArray:bulletsToRemove];
}

- (void)processCloneBullets {
    [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy][self.pilot.zx]];
    bool greaterZeroX = self.pilot.zx > 0;
    bool greaterZeroY = self.pilot.zy > 0;
    bool lessMaxX = self.pilot.zx < zonesWide - 1;
    bool lessMaxY = self.pilot.zy < zonesTall - 1;
    if (greaterZeroX) {
        [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy][self.pilot.zx-1]];
        if (greaterZeroY) {
            [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy-1][self.pilot.zx-1]];
        } else if (lessMaxY) {
            [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy+1][self.pilot.zx-1]];
        }
    } else if (lessMaxX) {
        [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy][self.pilot.zx+1]];
        if (greaterZeroY) {
            [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy-1][self.pilot.zx+1]];
        } else if (lessMaxY) {
            [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy+1][self.pilot.zx+1]];
        }
    }
    
    if (lessMaxX) {
        [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy][self.pilot.zx+1]];
    } else if (lessMaxY) {
        [self processCloneBulletsInZone:self.cloneZones[self.pilot.zy+1][self.pilot.zx]];
    }
    
    for (Bullet *b in self.cloneBullets) {
        if (b.crushes > 0) {
            NSMutableArray *a = self.zones[b.zy][b.zx];
            for (Bullet *bb in a) {
                if (ccpDistance(b.l, bb.l) < 4) {
                    [b crushBullet:bb];
                }
            }
        }
    }
}

- (void)bulletPulse {
    [self pulseBullets:self.bullets];
    [self pulseCloneBullets:self.cloneBullets];
    
    [self processPilotBullets];
    [self processCloneBullets];
    
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

- (NSInteger)currentScoreBonus {
    NSDictionary *total = [self levelScore];
    NSNumber *acc = total[QP_BF_ACCSCORE];
    NSNumber *path = total[QP_BF_PATHSCORE];
    
    return [acc intValue] + [path intValue];
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
    
    return @{QP_BF_ACCSCORE: accBonus, QP_BF_PATHSCORE: pathingBonus, QP_BF_SCORE: currentScore};
}

- (void)resetLevelScore {
    hits = 0;
    shotsFired = 0;
    paths = 1;
    totalPaths++;
}

- (void)processWaveKill {
    AudioServicesPlaySystemSound(process);
    _recentBonus += [self currentScoreBonus];

    self.pilot.l = ccp(5000,-5000);
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
//    [self.scoreCycler addScoring:[self levelScore]];
    self.score = [self.scoreCycler actualScore];
    [self changeState:self.pausedState];
    [self resetLevelScore];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PathsPulse" object:nil];
    [self eraseBullets];
    [self.dl reset];
    weaponLevel = 0;
    level++;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WaveLabel" object:[NSString stringWithFormat:@"WAVE\n%d", level]];
    
    if (!veteran &&level == 2) {
        [self playCopySound];
    }
    
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
        AudioServicesPlaySystemSound(process);
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

- (void)resetDrawRadius {
    drawRadius = 50;
}

- (int)zigzagTotal {
    return 30;
}

- (void)setupZigZags {
    _guideMode = zigzag;
    zigzags[0] = self.pilot.l;
    for (int i = 1; i < [self zigzagTotal]; i++) {
        int rx = arc4random() % 4;
        if (arc4random() % 2 == 0) {
            rx = -rx;
        }
        zigzags[i] = ccp(zigzags[i-1].x + rx, zigzags[i-1].y + 3);
    }
}

- (void)pulseCircleDrawings {
    switch (_guideMode) {
        case circle:
            drawRadius--;
            if (drawRadius < 8) {
                if (self.currentState == self.fightingState) {
                    [self resetDrawRadius];
                    break;
                } else if (self.currentState == self.titleState || self.currentState == self.pausedState) {
                    
                    drawRadius = 0;
                    
                    if (level == 1 && !veteran && !_playedDrag) {
                        [self playDragSound];
                    }
                    [self setupZigZags];
                }
            }
            break;
        case zigzag:
            drawRadius++;
            if (drawRadius > [self zigzagTotal]) {
                [self resetDrawRadius];
                _guideMode = circle;
            }
            break;
        case fire:
            drawRadius--;
            if (drawRadius <= 1) {
                drawRadius = 20;
            }
            break;
        default:
            break;
    }
    
    if (_guideMode == zigzag) {
        
    }
}

- (void)calculateTitleDraws {
    drawX = (_screenSize.width / 2 - ((float)_coresCollected * (float)3)) + 3;
}

- (void)pulseLineX {
    if (lXDirection == -1) {
        l1x -= 10;
        l2x += 10;
        if (l1x <= -_battlefieldFrame.size.width) {
            lXDirection = 0;
        }
        
        l3h-= 2;
        if (l3h < 0) {
            l3h = 0;
        }
        
//        float percentage = (_battlefieldFrame.size.width - l2x) / _battlefieldFrame.size
//        .width;
//
//        if (percentage > 1/3) {
//            l3y = l1y - (90 - (percentage * 90));
//        }
////
//        if (l1x < _battlefieldFrame.size.width * 2/3) {
////            l3y+= ;
//            if (l3y > l1y) {
//                l3y = l1y;
//            }
//        }
    } else if (lXDirection == 1) {
        l1x +=10;
        l2x-= 10;
        l3h+= 2;
        if (l3h > 45) {
            l3h = 45;
        }
        
        if (l1x >= 0) {
            l1x = 0;
            l2x = 0;
            lXDirection = 0;
            [self.pilot resetPosition];
        }
    }
}

- (void)resetLineXDirection:(int)lxd {
    lXDirection = lxd;
}

- (void)pulse {
    [self calculateTitleDraws];
    [self pulseCircleDrawings];
    [self.currentState pulse];
    [self rhythmPulse];
    [self shieldDebrisPulse];
    [self shatterPulse];
    [self scorePulse];
    
    [self pulseLineX];
    
    if ([self isPulsing]) {
        [self debrisPulse];
        [self.pilot pulse];
        [self clonesPulse];
        [self killPulse];
        [self bulletPulse];
        [self moveDeadline];
    } else {
        [self.pilot defineEdges];
        [self.pilot prepareDeltaDraw];
        for (QuantumClone *c in self.clones) {
            [c defineEdges];
        }
        
        if (self.currentState == self.titleState || self.currentState == self.pausedState) {
    
        } else {
            [self scorePulse];
        }
    }
}

- (void)scorePulse {
    [self.scoreCycler pulse];
    NSInteger currentScore = [self.scoreCycler displayedScore];
    NSInteger bonus = [self currentScoreBonus];
    
    [self.scoreCycler score:_recentBonus];
    _recentBonus = 0;
    
    NSString *scoreDisplay = @"";
    if (self.pilot.fightingIteration == 0) {
        scoreDisplay = [NSString stringWithFormat:@"%d", currentScore + 0];
    } else {
        NSString *bonusDisplay = bonus >= 200480 ? @"PERFECT" : [NSString stringWithFormat:@"%d", bonus];
        scoreDisplay = [NSString stringWithFormat:@"%d + %@", currentScore, bonusDisplay];
        
    }
    
    if (self.currentState == self.titleState) {
        scoreDisplay = [NSString stringWithFormat:@"%d", -lastScore];
    }
    
    if (currentScore > 0 || -lastScore < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScoreLabel" object:[NSString stringWithFormat:@"%@", scoreDisplay]];
    }
    
    if (self.currentState != self.titleState) {
        NSNumber *accAnnouncement;
        if (totalShotsFired > 0) {
            int acc = (int)ceil((((float)totalHits / (float)totalShotsFired)) * 100.0);
            if (acc > 100) {
                acc = 100;
            }
            accAnnouncement = [NSNumber numberWithInteger:acc];
        } else {
            accAnnouncement = [NSNumber numberWithInteger:100];
        }
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyLabel" object:@{@"accuracy" : [accAnnouncement stringValue], @"corner" : [NSNumber numberWithBool:true]}];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"PathsLabel" object:[NSNumber numberWithInteger:totalPaths]];
    }

}

#pragma mark States

- (void)changeState:(QPBFState *)state withOptions:(NSDictionary *)options {
    if (self.currentState) {
        [self.currentState deactivate];
    }
    
    self.currentState = state;
    [self.currentState activate:options];
    
    [self updateBottomCoreLabel];
}

- (void)changeState:(QPBFState *)state {
    [self changeState:state withOptions:nil];
}

- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l {
    if (self.currentState == self.fightingState && state != self.pausedState) {
        paths++;
        totalPaths++;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PathsPulse" object:nil];
    }
    [self changeState:state];
    [self.currentState addTouch:l];
}

#pragma mark Input

- (void)addTouch:(CGPoint)l {
    drawRadius = 13;
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
    return [self.pilot touchesPoint:l];
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
}

#pragma mark Bullet Delegate

- (void)playBulletSound:(int)li {
    switch (li) {
        case 0:
            AudioServicesPlaySystemSound(l1);
            break;
        case 1:
            AudioServicesPlaySystemSound(l2);
            break;
        case 2:
            AudioServicesPlaySystemSound(l3);
            break;
        case 3:
            AudioServicesPlaySystemSound(l4);
            break;
        case 4:
            AudioServicesPlaySystemSound(l5);
            break;
        case 5:
            AudioServicesPlaySystemSound(l6);
            break;
        case 6:
            AudioServicesPlaySystemSound(l7);
            break;
            
        default:
            break;
    }
}

- (void)bulletsFired:(NSArray *)bullets li:(int)li {
    [self playBulletSound:li];
    
    for (Bullet *b in bullets) {
        [self addChild:b];
        b.tag = -1;
        b.delegate = self;

        
        NSMutableArray *a = self.zones[b.zy][b.zx];
        [a addObject:b];
    }
    
    [self.bullets addObjectsFromArray:bullets];
    [self.scoreCycler score:1];
}

- (void)cloneBulletsFired:(NSArray *)bullets li:(int)li {
    [self playBulletSound:li];
    for (Bullet *b in bullets) {
        [self addChild:b];
        b.tag = 0;
        b.delegate = self;
        
        NSMutableArray *a = self.cloneZones[b.zy][b.zx];
        [a addObject:b];
    }
    
    [self.cloneBullets addObjectsFromArray:bullets];
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
    [self generateSpeedMod];
    float speed = 1.6f + (float)((arc4random() % 50) * 0.01f);
    [self.pilot setSpeed:speed * [self speedMod]];
    
    [self.dl reset];
    self.dl.speed *= [self speedMod];
}

#pragma mark Pilot effects

- (void)drawTitleState {
    if (_coresCollected > 0) {
        [self drawCharges];
    }
    
//    if ([self.titleState showingScore]) {
//        ccDrawColor4F(1, 1, 1, 1.0);
//        if (lastScore > 0) {
//            ccDrawPoly(_leaderboardPoints, 10, NO);
//        }
//    } else {
//        
//    }
}

- (void)drawCharges {
    for (int i = 0; i < _coresCollected; i++) {
        CGPoint c = ccp(drawX, 28);
        ccDrawFilledCircle(c, 1.7, 0, 30, NO);
        
        drawX+=6;
        if (i == _coresCollected - 1) {
            [self calculateTitleDraws];
        }
    }
}

- (void)drawGuideMode {
    switch (_guideMode) {
        case circle:
            ccDrawCircle(self.pilot.l, drawRadius, 0, 50, 0);
            break;
        case zigzag:
            ccDrawPoly(zigzags, drawRadius, 0);
            break;
        case fire:
            ccDrawCircle(fireCircle, drawRadius, 0, 30, 0);
            break;
        default:
            break;
    }
}

- (void)drawSidelines {
    ccDrawLine(ccp(l1x, l1y), ccp(l1x + _battlefieldFrame.size.width, l1y));
    ccDrawLine(ccp(l2x, l2y), ccp(l2x + _battlefieldFrame.size.width, l2y));
    ccDrawLine(ccp(l1x, l2y), ccp(l1x + _battlefieldFrame.size.width, l2y));
    ccDrawLine(ccp(l2x, l1y), ccp(l2x + _battlefieldFrame.size.width, l1y));

    if (_score > 0 || lastScore > 0) {
        ccDrawLine(ccp(l1x, l1y - 90), ccp(l1x + _battlefieldFrame.size.width, l1y - 90));
        ccDrawLine(ccp(l2x, l1y - 90), ccp(l2x + _battlefieldFrame.size.width, l1y - 90));
        
        ccDrawLine(ccp(l3x, l1y - 45 - l3h), ccp(l3x, l1y - 45 + l3h));
        ccDrawLine(ccp(l4x ,l1y - 45 - l3h), ccp(l4x, l1y - 45 + l3h));
    }
}

- (void)draw {
    [super draw];
    
    [[Arsenal weaponIndexedFromArsenal:[self.pilot arsenalLevel]] setDrawColor];
    [self drawSidelines];

    [self drawGuideMode];
    
    if (self.currentState == self.titleState) {
        [self drawTitleState];
    } else {
        [self drawCharges];
    }
    
    [self drawCharges];
}

- (float)bulletSpeed {
    return _bulletSpeed * [self speedMod];
}

- (void)playDragSound {
    _playedDrag = true;
    AudioServicesPlaySystemSound(drag);
}
- (void)playTapSound {
    if (level == 1 && self.pilot.time == 2 && !veteran) {
        AudioServicesPlaySystemSound(tap);
    }
}
- (void)playCopySound {
    AudioServicesPlaySystemSound(copy);
}

- (void)generateSpeedMod {
    _bulletSpeed = 1.8f + (float)((arc4random() % 250) * 0.01f);
    if (_coreCycles > 0) {
        _speedMod = 0.4f + (0.006f * (arc4random() % _coreCycles));
        NSLog(@"speedmod: %f", _speedMod);
        return;
    }
    
    _speedMod = 0.4f;
    NSLog(@"speedmod: %f", _speedMod);
}

- (float)speedMod {
    return _speedMod;
}

- (void)bulletChangedZone:(Bullet *)b {
    if (b.zone) {
        NSMutableArray *a = self.zones[b.zy][b.zx];
        [a removeObject:b];
    }
    
    if ([self bulletOutOfBounds:b]) {
        return;
    }
    
    NSMutableArray *a = self.zones[b.zy][b.zx];
    [a addObject:b];
}

- (void)cloneBulletChangedZone:(Bullet *)b {
    if (b.zone) {
        NSMutableArray *a = self.cloneZones[b.zy][b.zx];
        [a removeObject:b];
    }

    if ([self bulletOutOfBounds:b]) {
        return;
    }
    
    NSMutableArray *a = self.cloneZones[b.zy][b.zx];
    [a addObject:b];
}

#pragma mark State Control

- (void)showCircleGuideMode {
    if (!veteran) {
        _guideMode = circle;
    }
}

- (void)resetGuideMode {
    if (!veteran && level < 4) {
        _guideMode = fire;
    } else {
        _guideMode = rest;
    }
}

- (void)restGuideMode {
    _guideMode = rest;
}

- (void)resetFireCircle {
    fireCircle = [self fireCircleReset];
}

- (void)moveFireCircleOffscreen {
    fireCircle = ccp(5000,5000);
}

- (void)resetScoringTotals {
    totalShotsFired = 0;
    totalHits = 0;
    totalPaths = 0;
}

- (bool)showSocial {
    return lastScore > 0;
}

- (NSString *)shareText {
    int t = arc4random() % 5;
    
    NSString *v = @"";
    switch (t) {
        case 0:
            v = [NSString stringWithFormat:@"I dismantled %d clone ships in Quantum Pilot with %d%%    1 accuracy. Can you defeat yourself? %@", totalHits, [self accuracy], @"https://itunes.apple.com/us/app/quantum-pilot/id935956154?mt=8"];
            break;
        case 1:
            v = [NSString stringWithFormat:@"I melted %d clone ships in Quantum Pilot with %d points. Can you defeat yourself? %@", totalHits, lastScore, @"https://itunes.apple.com/us/app/quantum-pilot/id935956154?mt=8"];
            break;
        case 2:
            v = [NSString stringWithFormat:@"I destroyed %d clone ships in Quantum Pilot from only %d paths. Can you defeat yourself? %@", totalHits, totalPaths, @"https://itunes.apple.com/us/app/quantum-pilot/id935956154?mt=8"];
            break;
            
        default:
            v = [NSString stringWithFormat:@"I'm crushing it in Quantum Pilot with %d from %d clone ship kills. Can you defeat yourself? %@", lastScore, totalHits, @"https://itunes.apple.com/us/app/quantum-pilot/id935956154?mt=8"];
            break;
    }
    
    return v;
}

- (void)announceScores {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowScores" object:@""];
    [self scorePulse];
    
}

- (int)maxUpgrade {
    return 5;
}

- (void)upgradeBoost:(UpgradeButton *)b {
    if (_coreCycles > 0 && boostLevel < [self maxUpgrade]) {
        _coreCycles--;
        boostLevel++;
        [self.pilot powerBoost];
    }
    
    [self updateBoostLabel];
    [self updateBottomCoreLabel];
}

- (void)updateBoostLabel {
    NSString *boostText = [NSString stringWithFormat:@"ζ\n+%d◊", boostLevel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BoostLabel" object:boostText];
}

- (void)upgradeLaser:(UpgradeButton *)b {
    if (_coreCycles > 0 && laserLevel < [self maxUpgrade]) {
        _coreCycles--;
        laserLevel++;
        [self.pilot powerLaser];
    }
    
    [self updateLaserLabel];
    [self updateBottomCoreLabel];
}

- (void)updateLaserLabel {
    NSString *laserText = [NSString stringWithFormat:@"¤\n+%d◊", laserLevel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LaserLabel" object:laserText];
}

- (bool)finishedAnimatingSidelines {
    return lXDirection == 0;
}


@end
