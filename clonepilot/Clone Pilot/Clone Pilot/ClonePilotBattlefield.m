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
@synthesize fireLayer1;
@synthesize fireLayer2;
@synthesize lastMove;
@synthesize timestamps;
@synthesize moveTimestamp;
@synthesize moveDate;
@synthesize moveStart;
@synthesize movementVector;

int const QP_TouchTargetingYOffset  = 30;
int const QP_AccuracyBonusModifier  = 100;
int const QP_MaxTime                = 2000;
int const QP_TimeBonusModifier      = 3;

- (id)commonInit {
    self = [super init];
    if (self) {
        self.clones = [NSMutableArray array];
        self.weaponSelector = [[WeaponSelector alloc] initWithBattlefield:self];
        self.timestamps = [NSMutableArray array];
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
    
//    self.fireLayer1 = [[[QPFireLayer alloc] init] autorelease];
//    self.fireLayer1.delegate = self;
//    [self.fireLayer1 setContentSizeInPixels:CGSizeMake(100, 200)];
//    self.fireLayer1.positionInPixels = ccp(0,1024-200);
//    [quantumLayer addChild:self.fireLayer1];
//    
//    self.fireLayer2 = [[[QPFireLayer alloc] init] autorelease];
//    self.fireLayer2.delegate = self;
//    [self.fireLayer2 setContentSizeInPixels:CGSizeMake(100, 200)];
//    self.fireLayer2.positionInPixels = ccp(768-100,1024-200);
//    [quantumLayer addChild:self.fireLayer2];
    
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
    if (self.moveActive) {
        self.player.t = CombinedPoint(self.player.l, MultipliedPoint(self.movementVector, self.player.speed));
    } else {
        self.player.t = self.player.l;
    }
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

- (NSInteger)timeBonus {
    NSInteger bonusTime = (QP_MaxTime - self.time) * QP_TimeBonusModifier;
    return bonusTime;
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
    self.level++;
    [self scoreForAccuracy];
    [self scoreForSpeed];
    self.hits = 0;
    self.shotsFired = 0;
    self.player.weapon = weapon;
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    [self.weaponSelector chooseWeapon:choiceIndex];
//    [self scoreForHealth];
//    self.hits = 0;    
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

- (BOOL)pointWithinFiringLayer:(CGPoint)l {
    return CGRectContainsPoint(self.fireLayer1.boundingBoxInPixels, CGPointMake(l.x, 1024-l.y)) ||
    CGRectContainsPoint(self.fireLayer2.boundingBoxInPixels, CGPointMake(l.x, 1024-l.y));
}

- (void)plusTouch:(UITouch *)t {

}

- (void)varyTouch:(UITouch *)t {
    
}

- (void)finishTouch:(UITouch *)t {
    
}

- (void)addTouch:(CGPoint)l last:(CGPoint)last timestamp:(NSTimeInterval)timestamp {
    if (!self.moveActive) {
        self.moveActive = YES;
        self.moveStart = l;
        self.lastMove = l;
        self.moveTimestamp = [[NSDate date] timeIntervalSince1970] - timestamp;
        self.moveDate = [NSDate date];
        
    } else {
        [[self player] fire];
    }
    //    if (!self.moveActive) {
//        if (![self pointWithinFiringLayer:l]) {
//            [self modifyPlayerTargetWithTouchLocation:l];
//            self.moveActive = YES;
//        }
//    }
}

- (void)addTouch:(CGPoint)l {
    [self addTouch:l last:CGPointZero];
}

- (BOOL)closeEnoughToLast:(CGPoint)l {
    return GetDistance(self.lastMove, l) < 20;
}

- (void)moveTouch:(CGPoint)l last:(CGPoint)last timestamp:(NSTimeInterval)timestamp{
//    NSTimeInterval ts = [[NSDate date] timeIntervalSince1970] - timestamp;
//    if (ts == self.moveTimestamp) {
    if ([self closeEnoughToLast:last]) {
        self.lastMove = l;
        self.movementVector = GetAngle(self.moveStart, self.lastMove);
//    if (last.x == self.lastMove.x && last.y == self.lastMove.y) {
//        CGPoint target = GetAngle(self.lastMove, l);
//        CGPoint vector = MultipliedPoint(target, self.player.speed);
//        self.player.t = CombinedPoint(self.player.l, vector);
//        self.lastMove = l;
    }
    
}

- (void)moveTouch:(CGPoint)l {
    [self moveTouch:l last:CGPointZero];
}

- (void)endTouch:(CGPoint)l last:(CGPoint)last timestamp:(NSTimeInterval)timestamp{
    NSTimeInterval ts = [[NSDate date] timeIntervalSince1970] - timestamp;
    if ([self closeEnoughToLast:last]) {
        self.movementVector = CGPointZero;
        self.moveActive = NO;
    }
//    if (![self pointWithinFiringLayer:l]) {    
//        self.player.t = self.player.l;
//        self.moveActive = NO;
//    }
}

- (void)endTouch:(CGPoint)l {
    [self endTouch:l last:CGPointZero];
}

- (BOOL)playing {
    return !_paused;
}

- (void)togglePlaying {
    _paused = !_paused;
}

- (void)fireLayerTapped:(QPFireLayer *)fireLayer {
    [self.player fire];
}

- (void)dealloc {
    [player release];
    [clones release];
    [weaponSelector release];
    self.layer = nil;
    [wall release];
    [fireLayer1 removeFromParentAndCleanup:YES];
    [fireLayer1 release];    
    [timestamps release];
    [super dealloc];
}

@end
