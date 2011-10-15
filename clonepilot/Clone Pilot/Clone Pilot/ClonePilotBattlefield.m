#import "ClonePilotBattlefield.h"
#import "VRGeometry.h"

@implementation ClonePilotBattlefield

@synthesize player;
@synthesize clones;

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] initWithLocation:[ClonePlayer defaultLocation]] autorelease];
        self.player.bulletDelegate = self;
        self.clones = [NSMutableArray array];
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
    NSMutableArray *copiedManuevers = [[self.player currentMoves] copy];
    [self latestClone].moves = copiedManuevers;
    [copiedManuevers release];
    [self.player reset];
}

- (void)advanceLevel {
    _level++;
    [self activateAllClones];
    [self addClone];
    [self copyPlayerMovesToNewClone];
}

- (void)killClone:(ClonePilot *)pilot {
    pilot.living = NO;
    if ([self livingClones] == 0) {
        [self advanceLevel];
    }
}

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        for (ClonePilot *p in self.clones) {
            if (GetDistance(b.l, p.l) <= b.radius + p.radius) {
                [self killClone:p];
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

- (void)dealloc {
    [player release];
    [clones release];
    [super dealloc];
}

@end
