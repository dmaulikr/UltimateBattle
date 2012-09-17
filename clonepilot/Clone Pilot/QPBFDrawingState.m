#import "QPBFDrawingState.h"
#import "QPBattlefield.h"

@implementation QPBFDrawingState

- (void)tick {
    [self.f addXDelta:self.f.playerTouch.x - self.f.lastPlayerTouch.x];
    [self.f addYDelta:self.f.playerTouch.y - self.f.lastPlayerTouch.y];    
    self.f.drawingIteration++;
}

- (void)addTouch:(CGPoint)l {
    float xOffset = l.x - self.f.player.l.x;
    float yOffset = l.y - self.f.player.l.y;
    self.f.touchPlayerOffset = ccp(xOffset, yOffset);
    self.f.playerTouch = l;
    self.f.lastPlayerTouch = l;
}

- (void)endTouch:(CGPoint)l {
    [self.f changeState:self.f.fightingState];
}

- (void)moveTouch:(CGPoint)l {
    if ([self.f touchingPlayer:l]) {
        self.f.playerTouch = l;
    }
}

@end
