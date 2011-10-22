#import "ClonePilotBattlefield.h"
#import "VRGeometry.h"

#define CLONE_KILL_VALUE 1

@implementation ClonePilotBattlefield

@synthesize player;
@synthesize clones;
@synthesize score;
@synthesize shotsFired;
@synthesize hits;
@synthesize weaponChoices;
@synthesize splitLaser;
@synthesize triLaser;

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] init] autorelease];
        self.player.bulletDelegate = self;
        self.clones = [NSMutableArray array];
        self.splitLaser = [[[SplitLaser alloc] init] autorelease];
        self.triLaser = [[[TriLaser alloc] init] autorelease];
    }
    return self;
}

- (void)addClone {
    ClonePilot *p = [[ClonePilot alloc] init];
    [self.clones addObject:p];
    [p release];
}

- (void)activateAllClones {
    for (ClonePilot *p in self.clones) {
        p.living = YES;
    }
}

- (void)copyPlayerMovesToNewClone {
    NSMutableArray *copiedManuevers = [[NSMutableArray alloc] initWithArray:[self.player currentMoves] copyItems:YES];
    for (Turn *t in copiedManuevers) {
        if (fabsf(t.vel.x) + fabsf(t.vel.y) > 0) {
            t.vel = CGPointMake(-t.vel.x, -t.vel.y);
        }
    }
    [self latestClone].moves = copiedManuevers;
    [copiedManuevers release];
    [self.player reset];
}

- (void)copyPlayerWeaponToNewClone {
    Weapon *w = [self.player.weapon copy];
    [self latestClone].weapon = w;
    [w release];
}

- (NSInteger)accuracyScoreModifier {
    return 10;
}

- (void)assignWeaponToPlayer {
    switch (self.level) {
        case 1:
            self.player.weapon = [[[TriLaser alloc] init] autorelease];
            break;
        case 2:
            break;
            
        default:
            break;
    }
}

- (void)openWeaponOptions {
    self.weaponChoices = [NSArray arrayWithObjects:self.splitLaser, self.triLaser, nil];
}

- (void)advanceLevel {
    [self activateAllClones];
    [self addClone];
    [self copyPlayerMovesToNewClone];
    [self copyPlayerWeaponToNewClone];
    [self openWeaponOptions];
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
        [self advanceLevel];
    }
}

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        for (ClonePilot *p in self.clones) {
            if (GetDistance(b.l, p.l) <= b.radius + p.radius) {
                [self killClone:p];
                self.hits++;
                b.finished = YES;
            }
        }
    }
    
    [super bulletLoop];
}

- (void)cloneLoop {
    NSMutableArray *finishedClones = [NSMutableArray array];
    for (ClonePilot *p in self.clones) {
        if (![p living]) {
            [finishedClones addObject:p];
        }
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

- (void)startup {
    [self addClone];
}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    self.level++;
    self.player.weapon = [self.weaponChoices objectAtIndex:choiceIndex];
}

- (void)dealloc {
    [player release];
    [clones release];
    [weaponChoices release];
    [splitLaser release];
    [triLaser release];
    [super dealloc];
}

@end
