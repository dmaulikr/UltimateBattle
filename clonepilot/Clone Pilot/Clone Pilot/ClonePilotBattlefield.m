#import "ClonePilotBattlefield.h"


@implementation ClonePilotBattlefield

@synthesize player;

- (id)init {
    self = [super init];
    if (self) {
        self.player = [[[ClonePlayer alloc] initWithLocation:CGPointMake(384,500)] autorelease];
        self.player.bulletDelegate = self;
    }
    return self;
}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)dealloc {
    [player release];
    [super dealloc];
}

@end
