#import "QPBFDrawingState.h"
#import "QPBattlefield.h"

@implementation QPBFDrawingState

- (void)pulse {
    [self.f addDelta:self.f.playerTouch];
    self.f.drawingIteration++;
    if (self.f.drawingIteration >= QPBF_MAX_DRAWING_FRAMES) {
//        [self.f changeState:self.f.fightingState];
    }
}

- (void)setPlayerTouch:(CGPoint)l {
    self.f.playerTouch = l;
    self.f.lastPlayerTouch = l;
    self.f.latestExpected = self.f.pilot.l;
}

- (void)addTouch:(CGPoint)l {
    float xOffset = l.x - self.f.pilot.l.x;
    float yOffset = l.y - self.f.pilot.l.y;
    self.f.touchPlayerOffset = ccp(xOffset, yOffset);
    [self setPlayerTouch:l];
}

- (void)endTouch:(CGPoint)l {
  //  [self.f changeState:self.f.fightingState];
}

- (void)moveTouch:(CGPoint)l {
    self.f.playerTouch = l;
}

@end
