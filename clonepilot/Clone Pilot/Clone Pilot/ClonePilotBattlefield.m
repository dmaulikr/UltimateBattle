#import "ClonePilotBattlefield.h"
#import "ClonePilot.h"

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
    }
}

- (void)tick {
    [self bulletLoop];
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
