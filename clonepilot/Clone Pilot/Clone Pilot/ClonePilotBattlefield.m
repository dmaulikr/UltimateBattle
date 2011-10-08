#import "ClonePilotBattlefield.h"
#import "ClonePilot.h"
#import "VRGeometry.h"

@implementation ClonePilotBattlefield

@synthesize player;
@synthesize clones;

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] initWithLocation:CGPointMake(384,300)] autorelease];
        self.player.bulletDelegate = self;
        self.clones = [NSMutableArray array];
    }
    return self;
}

- (void)spawnFirstClone {
    ClonePilot *p = [[ClonePilot alloc] init];
    [self.clones addObject:p];
    [p release];
}

- (void)advanceLevel {
    _level++;
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

- (void)startup {
    [self spawnFirstClone];
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
