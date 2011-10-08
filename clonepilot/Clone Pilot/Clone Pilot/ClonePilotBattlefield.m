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

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        [b tick];
        for (ClonePilot *p in self.clones) {
            if (GetDistance(b.l, p.l) <= b.radius + p.radius) {
                p.living = NO;
            }
        }
    }
}

- (void)playerLoop {
    [self.player tick];
}

- (void)tick {
    [self bulletLoop];
    [self playerLoop];
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
