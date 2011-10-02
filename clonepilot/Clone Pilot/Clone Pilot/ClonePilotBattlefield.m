#import "ClonePilotBattlefield.h"


@implementation ClonePilotBattlefield

@synthesize player;

- (void)dealloc {
    [player release];
    [super dealloc];
}

@end
