#import "QPBFDrawingState.h"
#import "QPBattlefield.h"

@implementation QPBFDrawingState

- (void)tick {
    [self.f addXDelta:self.f.playerTouch.x];
    [self.f addYDelta:self.f.playerTouch.y];
//    [self.f addXDelta:self.f.playerTouch.x - self.f.lastPlayerTouch.x];
//    [self.f addYDelta:self.f.playerTouch.y - self.f.lastPlayerTouch.y];
    self.f.drawingIteration++;
    if (self.f.drawingIteration == QPBF_MAX_DRAWING_FRAMES) {
        [self.f changeState:self.f.fightingState];
    }
//    self.f.lastPlayerTouch = self.f.playerTouch;
//    [self setPlayerTouch:self.f.playerTouch];
}

- (void)setPlayerTouch:(CGPoint)l {
    self.f.playerTouch = l;
    self.f.lastPlayerTouch = l;
    self.f.latestExpectedX = self.f.player.l.x;
    self.f.latestExpectedY = self.f.player.l.y;
}

- (void)addTouch:(CGPoint)l {
    float xOffset = l.x - self.f.player.l.x;
    float yOffset = l.y - self.f.player.l.y;
    self.f.touchPlayerOffset = ccp(xOffset, yOffset);
    [self setPlayerTouch:l];
}

- (void)endTouch:(CGPoint)l {
    [self.f changeState:self.f.fightingState];
}

- (void)moveTouch:(CGPoint)l {
//    [self setPlayerTouch:l];
//    if ([self.f touchingPlayer:l]) {
        self.f.playerTouch = l;
  //  }
}

@end
