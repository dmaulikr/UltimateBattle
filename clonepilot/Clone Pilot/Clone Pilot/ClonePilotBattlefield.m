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

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] init] autorelease];
        self.player.bulletDelegate = self;
        self.clones = [NSMutableArray array];
        self.weaponSelector = [[WeaponSelector alloc] initWithBattlefield:self];
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

- (void)resetPlayer {
    [self.player reset];
    self.player.health = self.player.health+ 1;
}

- (void)clearBullets {
    for (Bullet *b in self.bullets) {
        b.finished = YES;
    }
    
    [super bulletLoop];
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

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        for (ClonePilot *p in self.clones) {
            if (b.identifier != [ClonePilot identifier]) {
                if (GetDistance(b.l, p.l) <= b.radius + p.radius) {
                    [self killClone:p];
                    self.hits++;
                    b.finished = YES;
                }
            }
        }
        
        if (GetDistance(b.l, [self player].l) <= b.radius + [[self player] radius]) {
            [[self player] hit:b];
        }
    }
    
    if (_shouldAdvanceLevel) {
        [self advanceLevel];
    }
    
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

- (void)tick {
    [super tick];
    [self playerLoop];
    [self cloneLoop];
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
    [self.bullets addObjectsFromArray:bullets];
}

- (void)playerChoseWeapon:(Weapon *)weapon {
    self.level++;
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

- (void)dealloc {
    [player release];
    [clones release];
    [weaponSelector release];
    [super dealloc];
}

@end
