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
@synthesize touches;

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] init] autorelease];
        self.player.bulletDelegate = self;
        self.clones = [NSMutableArray array];
        self.weaponSelector = [[WeaponSelector alloc] initWithBattlefield:self];
        self.touches = [NSMutableArray array];
    }
    return self;
}

- (void)addClone {
    ClonePilot *p = [[ClonePilot alloc] init];
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

- (NSInteger)accuracyScoreModifier {
    return 10;
}

- (void)resetClones {
    for (ClonePilot *p in self.clones) {
        [p reset];
    }
}

- (void)regeneratePlayerHealth {
    self.player.health = self.level + 1;
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

- (void)advanceLevel {
    _shouldAdvanceLevel = NO;
    [self clearBullets];
    [self activateAllClones];
    [self copyPlayerMovesToLatestClone];
    [self copyPlayerWeaponToLatestClone];
    [self addClone];
    [self resetClones];
    [self resetPlayer];
    [self.weaponSelector openWeaponOptions];
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
        if (b.identifier != [ClonePilot identifier]) {
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
    if (GetDistance(b.l, [self player].l) <= b.radius + [[self player] radius]) {
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
    NSMutableArray *finishedClones = [NSMutableArray array];
    for (ClonePilot *p in self.clones) {
        if (![p living]) {
            [finishedClones addObject:p];
        }
        [p tick];
    }
    [self.clones removeObjectsInArray:finishedClones];
}

- (void)playerLoop {
    [self.player tick];
}

- (void)resetBattlefield {
    [self.clones removeAllObjects];
    [self.bullets removeAllObjects];
    [self.player restart];
    self.level = 0;
    [self.weaponSelector restart];
    [self.touches removeAllObjects];
    _battlefieldEnding = NO;
    
}

- (void)tick {
    [super tick];
    [self playerLoop];
    [self cloneLoop];
    
    if (_battlefieldEnding) {
        [self resetBattlefield];
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
    [self addClone];
    [self.weaponSelector startup];
}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)addBullets:(NSArray *)bullets {
    for (Bullet *b in bullets) {
        [self.bullets addObject:b];
    }
}

- (void)playerChoseWeapon:(Weapon *)weapon {
    self.level++;
    self.player.weapon = weapon;
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    [self.weaponSelector chooseWeapon:choiceIndex];
    [self scoreForHealth];    
    [self regeneratePlayerHealth];        
}

- (NSArray *)weaponChoices {
    return self.weaponSelector.weaponChoices;
}

- (NSArray *)chosenWeapons {
    return [NSArray arrayWithArray:self.weaponSelector.chosenWeapons];
}

#pragma mark touches

- (void)addTouch:(VRTouch *)touch {
    if ([self.touches count] == 0) {
        [self.touches addObject:touch];
        self.player.t = touch.l;
    } else {
        [self.player fire];
    }
}

- (void)moveTouch:(CGPoint)l {

    VRTouch *closestTouch = nil;
    float distance = 10000;
    for (VRTouch *t in self.touches) {
        if (GetDistance(t.l, l) < distance) {
            distance = GetDistance(t.l, l);
            closestTouch = t;
        }
    }
    
    closestTouch.l = l;
    
}

- (void)dealloc {
    [player release];
    [clones release];
    [weaponSelector release];
    [touches release];
    [super dealloc];
}

@end
