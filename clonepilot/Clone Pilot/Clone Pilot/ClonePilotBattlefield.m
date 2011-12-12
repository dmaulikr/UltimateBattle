#import "ClonePilotBattlefield.h"
#import "VRGeometry.h"

#define CLONE_KILL_VALUE 1

@implementation ClonePilotBattlefield

@synthesize player;
@synthesize clones;
@synthesize score;
@synthesize shotsFired;
@synthesize hits;
@synthesize weaponSelector;
@synthesize layer;
@synthesize currentTarget;
@synthesize moveActive;
@synthesize time;
@synthesize wall;

int const QP_TouchTargetingYOffset = 30;
int const QP_AccuracyBonusModifier = 100;

- (id)commonInit {
    self = [super init];
    if (self) {
        self.clones = [NSMutableArray array];
        self.weaponSelector = [[WeaponSelector alloc] initWithBattlefield:self];
        self.time = 0;
    }
    return self; 
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self = [self commonInit];
    self.player = [[[ClonePlayer alloc] initWithLayer:quantumLayer] autorelease];
    self.player.bulletDelegate = self;
    self.layer = quantumLayer;
    self.wall = [[[BulletWall alloc] initWithLayer:quantumLayer] autorelease];
    
    return self;
}

- (id)init {
    self = [self commonInit];
    self.player = [[[ClonePlayer alloc] init] autorelease];
    self.player.bulletDelegate = self;
    return self;
}

- (void)addClone {
    ClonePilot *p = [[ClonePilot alloc] initWithLayer:self.layer];
    [self.clones addObject:p];
    p.bulletDelegate = self;
    [p release];
}

- (void)activateAllClones {
    for (ClonePilot *p in self.clones) {
        p.living = YES;
    }
}

- (void)copyPlayerMovesToLatestClone {
    NSMutableArray *copiedManuevers = [[NSMutableArray alloc] initWithArray:[self.player currentMoves] copyItems:YES];
    for (Turn *t in copiedManuevers) {
        if (fabsf(t.vel.x) + fabsf(t.vel.y) > 0) {
            t.vel = CGPointMake(t.vel.x, -t.vel.y);
        }
    }
    [self latestClone].moves = copiedManuevers;
    [copiedManuevers release];
}

- (void)copyPlayerWeaponToLatestClone {
    Weapon *w = [self.player.weapon copy];
    [self latestClone].weapon = w;
    [w release];
}

- (void)resetClones {
    for (ClonePilot *p in self.clones) {
        [p reset];
        if (p.sprite) {
            [p.sprite removeFromParentAndCleanup:YES];
        }
        [p resetSpriteWithLayer:self.layer];
    }
}

- (void)resetPlayer {
    [self.player reset];
}

- (void)clearBullets {
    for (Bullet *b in self.bullets) {
        b.finished = YES;
    }
    
    [super bulletLoop];
}

- (void)scoreForHealth {
    if (self.player.health == self.level) {
        self.score += [self fullHealthBonus];
    }
}

- (void)resetWall {
    [self.wall reset];
}

- (void)advanceLevel {
    _shouldAdvanceLevel = NO;
    [self clearBullets];
    [self copyPlayerMovesToLatestClone];
    [self copyPlayerWeaponToLatestClone];
    [self addClone];
    [self resetClones];
    [self activateAllClones];    
    [self resetPlayer];
    [self resetWall];
    [self.weaponSelector openWeaponOptions];
//    [self chooseWeapon:0];
}

- (void)fired {
    self.shotsFired++;
}

- (NSInteger)cloneKillValue {
    return 1;
}

- (NSInteger)fullHealthBonus {
    return 10;
}

- (void)advanceScoreForKillingClone {
    self.score+= [self cloneKillValue];
}

- (void)killClone:(ClonePilot *)pilot {
    pilot.living = NO;
    [self advanceScoreForKillingClone];
    if ([self livingClones] == 0) {
        _shouldAdvanceLevel = YES;
    }
}

- (void)checkForCloneCollision:(Bullet *)b {
    for (ClonePilot *p in self.clones) {
        if (!b.finished && p.living && b.identifier != [ClonePilot identifier]) {
            if (GetDistance(b.l, p.l) <= b.radius + p.radius) {
                [self killClone:p];
                self.hits++;
                b.finished = YES;
            }
        }
    }
}

- (void)endBattle {
    _battlefieldEnding = YES;
}

- (void)checkForDeadPlayer {
    if ([[self player] health] <= 0) {
        [self endBattle];
    }
}

- (void)checkForPlayerCollision:(Bullet *)b {
    if (!b.finished && GetDistance(b.l, [self player].l) <= b.radius + [[self player] radius]) {
        [[self player] hit:b];
    }
    
    [self checkForDeadPlayer];
}

- (void)checkToAdvanceLevel {
    if (_shouldAdvanceLevel) {
        [self advanceLevel];
    }
}

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        [self checkForCloneCollision:b];
        [self checkForPlayerCollision:b];      
    }
    
    [self checkToAdvanceLevel];

    
    [super bulletLoop];
}

- (void)cloneLoop {
    for (ClonePilot *p in self.clones) {
        if (![p living]) {
            if (p.sprite) {
                [p.sprite removeFromParentAndCleanup:YES];
            }
        }
        [p tick];
    }
}

- (void)playerLoop {
    [self.player tick];
}

- (void)resetBattlefield {
    for (ClonePilot *p in self.clones) {
        [p.sprite removeFromParentAndCleanup:YES];
    }
    
    for (Bullet *b in self.bullets) {
        [b.sprite removeFromParentAndCleanup:YES];
    }
    
    [self.clones removeAllObjects];
    [self.bullets removeAllObjects];
    [self.player restart];
    self.level = 0;
    self.score = 0;
    self.shotsFired = 0;
    self.hits = 0;
    
    self.weaponSelector.delegate = nil;
    self.weaponSelector = nil;

    self.weaponSelector = [[[WeaponSelector alloc] initWithBattlefield:self] autorelease];
    
    [self resetWall];
    
    [self startup];
}

- (void)timeloop {
    self.time++;
}

- (void)wallLoop {
    [self.wall tick];
    if (self.wall.l.y <= self.player.l.y) {
        self.player.health = -1;
    }
    [self checkForDeadPlayer];
}

- (void)tick {
    if ([self playing]) {
        [self timeloop];        
        if (_battlefieldEnding) {
            [self resetBattlefield];
        }
        [super tick];
        [self playerLoop];
        [self cloneLoop];        
        [self wallLoop];
    }
}

- (NSInteger)livingClones {
    NSInteger living = 0;
    for (ClonePilot *p in self.clones) {
        if ([p living]) {
            living++;
        }
    }
    return living;
}

- (ClonePilot *)latestClone {
    return [self.clones lastObject];
}

- (ClonePilot *)firstClone {
    return [self.clones objectAtIndex:0];
}

- (void)startup {
    _battlefieldEnding = NO;
    _paused = NO;
    [self addClone];
    [self.weaponSelector startup];
}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)addBullets:(NSArray *)bullets {
    for (Bullet *b in bullets) {
        [self.bullets addObject:b];
        [self.layer addChild:b.sprite];
    }
}

- (void)scoreForAccuracy {
    float accuracy = [self hits] / [self shotsFired];
    self.score += QP_AccuracyBonusModifier * accuracy * 100;
}

- (void)playerChoseWeapon:(Weapon *)weapon {
    self.level++;
    [self scoreForAccuracy];
    self.hits = 0;
    self.shotsFired = 0;
    self.player.weapon = weapon;
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    [self.weaponSelector chooseWeapon:choiceIndex];
    [self scoreForHealth];
    self.hits = 0;    
}

- (NSArray *)weaponChoices {
    return self.weaponSelector.weaponChoices;
}

- (NSArray *)chosenWeapons {
    return [NSArray arrayWithArray:self.weaponSelector.chosenWeapons];
}

#pragma mark touches

- (void)modifyPlayerTargetWithTouchLocation:(CGPoint)l {
    self.player.t = CGPointMake(l.x, l.y + QP_TouchTargetingYOffset);
}

- (void)addTouch:(CGPoint)l {
    if (!self.moveActive) {
        self.moveActive = YES;
        [self modifyPlayerTargetWithTouchLocation:l];
    } else {
        [self.player fire];
    }
}

- (void)moveTouch:(CGPoint)l {
    if (GetDistance(l, self.player.l) <= GetDistance(self.currentTarget, self.player.l)) {
        [self modifyPlayerTargetWithTouchLocation:l];
    } else {
        //ignore
    }
}

- (void)endTouch:(CGPoint)l {
    if (GetDistance(l, self.player.l) <= GetDistance(self.currentTarget, self.player.l)) {
        self.player.t = self.player.l;
    }
}

- (BOOL)playing {
    return !_paused;
}

- (void)togglePlaying {
    _paused = !_paused;
}

- (void)dealloc {
    [player release];
    [clones release];
    [weaponSelector release];
    self.layer = nil;
    [wall release];
    [super dealloc];
}

@end
