#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)tick {
    CGPoint deltaTarget = ccp(self.f.player.l.x + [self.f xDelta:self.f.fightingIteration],
                              self.f.player.l.y + [self.f yDelta:self.f.fightingIteration]);
    CGPoint direction = GetAngle(self.f.player.l, deltaTarget);
    self.f.player.vel = direction;
    
    self.f.fightingIteration++;    
}

@end
