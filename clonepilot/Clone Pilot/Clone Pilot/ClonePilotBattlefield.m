#import "ClonePilotBattlefield.h"
#import "VRGeometry.h"
#import "QPBattlefieldModifierController.h"

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
@synthesize lastMove;
@synthesize rSprite;
@synthesize inputHandler;
@synthesize moveAngle;

int const QP_TouchTargetingYOffset  = 30;
int const QP_AccuracyBonusModifier  = 100;
int const QP_MaxTime                = 2000;
int const QP_TimeBonusModifier      = 3;

- (void)createBattlefieldModifierController {
    self.battlefieldModifierController = [[[QPBattlefieldModifierController alloc] init] autorelease];
    [self addBattlefieldModifier:self.battlefieldModifierController];
}
 
- (void)setupBattlefieldModifiers { 
    [super setupBattlefieldModifiers];
}

- (void)resetModifiers {
    [self.battlefieldModifiers removeAllObjects];
    [self setupBattlefieldModifiers];
    [self createBattlefieldModifierController];
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.clones = [NSMutableArray array];
        self.weaponSelector = [[WeaponSelector alloc] initWithBattlefield:self];
        self.time = 0;
        self.inputHandler = [[[QPInputHandler alloc] init] autorelease];
        self.inputHandler.delegate = self;        
    }
    return self; 
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self            = [self commonInit];
    self.player     = [[[ClonePlayer alloc] initWithLayer:quantumLayer] autorelease];
    self.player.bulletDelegate = self;
    self.layer      = quantumLayer;
    self.wall       = [[[BulletWall alloc] initWithLayer:quantumLayer] autorelease];
    self.rSprite    = [CCSprite spriteWithFile:@"sprite-7-1.png"];
    [quantumLayer addChild:self.rSprite];        
    return self;
}

- (id)init {
    self = [self commonInit];
    self.player = [[[ClonePlayer alloc] init] autorelease];
    self.player.bulletDelegate = self;
    self.rSprite.position = CGPointMake(self.inputHandler.movePoint.x, 1024-self.inputHandler.movePoint.y);

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

- (void)removeClones {
    for (ClonePilot *p in self.clones) {
        [p removeFromParentAndCleanup:YES];        
    }
    [self.clones removeAllObjects];
}

- (void)resetClones {    
    if (self.level > 0 && self.level % 10 == 0) {
        [self removeClones];
        [self addClone];
    }
    
    for (ClonePilot *p in self.clones) {
        [p reset];
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

- (void)resetWall {
    [self.wall reset];
}

- (void)resetTime {
    self.time = 0;
}

- (void)ensurePlaying {
    if (![self playing]) {
        [self togglePlaying];
    }
}

- (void)ensurePaused {
    [self stopMoving];
}

- (void)openWeaponOptions {
    [self ensurePaused];
    [self.weaponSelector openWeaponOptions];
    [self.weaponSelector addWeaponOptionLayersToLayer:self.layer];

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
    [self openWeaponOptions];
    [self resetTime]; 
    [self resetWall];    
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
    [pilot ceaseLiving];
    [self advanceScoreForKillingClone];
    if ([self livingClones] == 0) {
        _shouldAdvanceLevel = YES;
    }
}

- (void)checkForCloneCollision:(Bullet *)b {
    for (ClonePilot *p in self.clones) {
        if (!b.finished && p.living && b.identifier != [ClonePilot identifier]) {
//            if ([p shipHitByBullet:b]) {
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
    if (![[self player] living]) {
        [self endBattle];
    }
}

- (void)checkForPlayerCollision:(Bullet *)b {
    if (!b.finished && [[self player] shipHitByBullet:b]) {
        //GetDistance(b.l, [self player].l) <= b.radius + [[self player] radius]) {
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
         //   [p removeFromParentAndCleanup:YES];
        }
        [p tick];
    }
}

- (void)playerLoop {
    [self.player tick];
    if (self.moveActive) {
        CGPoint invertedAngle = CGPointMake(self.moveAngle.x, -self.moveAngle.y);
        CGPoint t = CombinedPoint(self.player.l, invertedAngle);        
        self.player.t = t;
    } else {
        self.player.t = self.player.l;
    }
}

- (void)resetBattlefield {
    [self resetModifiers];
    [self removeClones];
    [self removeBullets];
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
    [self ensurePaused];
    
    [self.inputHandler endAllTouches];
    self.moveAngle = CGPointZero;
}

- (void)timeloop {
    self.time++;
}

- (void)wallLoop {
    [self.wall tick];
    if (self.wall.l.y <= self.player.l.y) {
        self.player.living = 0;
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
    [super addBullets:bullets];
    for (Bullet *b in bullets) {
        [self.layer addChild:b];
    }
}

- (NSInteger)timeBonus {
    NSInteger bonusTime = (QP_MaxTime - self.time) * QP_TimeBonusModifier;
    return bonusTime > 0 ? bonusTime : 0;
}

- (NSInteger)accuracyBonus {
    float accuracy = [self hits] / [self shotsFired];
    return floor(QP_AccuracyBonusModifier * accuracy * 100);
}

- (void)scoreForAccuracy {
    self.score += [self accuracyBonus];    
}

- (void)scoreForSpeed {
    self.score += [self timeBonus];
}

- (void)playerChoseWeapon:(Weapon *)weapon {
    for (BulletHellBattlefieldModifier *m in self.battlefieldModifiers) {
        [m levelGainedForBattlefield:self];
    }
    [self ensurePlaying];
    self.level++;
    [self scoreForAccuracy];
    [self scoreForSpeed];
    self.hits = 0;
    self.shotsFired = 0;
    self.player.weapon = weapon;
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    [self.weaponSelector chooseWeapon:choiceIndex];
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


- (void)plusTouch:(UITouch *)t {

}

- (void)varyTouch:(UITouch *)t {
    
}

- (void)addTouch:(CGPoint)l {
    if ([self.weaponSelector presentingOptions]) {
        [self.weaponSelector processWeaponSelectionFromLocationTapped:l];
    }
    
    if (!_paused) {
        [self.inputHandler addTouchPoint:l];
    } else {
        [self togglePlaying];
        [self.inputHandler addTouchPoint:l];    
    }
}

- (void)moveTouch:(CGPoint)l {    
    if ([self.weaponSelector presentingOptions]) {
        return;
    }

    
    [self.inputHandler moveTouchPoint:l];
}

- (void)endTouch:(CGPoint)l {
    [self.inputHandler endTouchPoint:l];
}

- (void)movementAngle:(CGPoint)angle distanceRatio:(float)ratio {
    self.moveActive = YES;
    float modifier = ratio * self.player.speed;
    self.moveAngle = MultipliedPoint(angle, modifier);
}

- (void)fireTapped {
    [self.player fire];
}

- (void)stopMoving {
    if (!_paused) {
        [self togglePlaying];
        self.moveActive = NO;
        self.player.t = self.player.l;
        self.moveAngle = CGPointZero;        
        [self.inputHandler endAllTouches];
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
    [inputHandler release];
    [super dealloc];
}

@end
