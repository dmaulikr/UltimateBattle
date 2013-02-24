#import "QPBFDrawingState.h"
#import "QPBattlefield.h"

@implementation QPBFDrawingState

- (void)pulse {
    if (self.f.time < QPBF_MAX_DRAWING_FRAMES) {
        [self.f.pilot addWaypoint:[self.f playerTouchWithOffset]];
        self.f.latestExpected = self.f.playerTouch;
    }

    self.f.pilot.drawingIteration++;
    if (self.f.pilot.drawingIteration >= QPBF_MAX_DRAWING_FRAMES) {
        [self.f changeState:self.f.fightingState];
    }
}



- (void)setPlayerTouch:(CGPoint)l {
    self.f.playerTouch = l;
    self.f.lastPlayerTouch = l;
    self.f.latestExpected = self.f.pilot.l;
}

- (void)addTouch:(CGPoint)l {
//    float xOffset = l.x - self.f.pilot.l.x;
//    float yOffset = l.y - self.f.pilot.l.y;
//    self.f.touchPlayerOffset = ccp(xOffset, yOffset);
    [self setPlayerTouch:l];
}


- (void)endTouch:(CGPoint)l {
    [self.f changeState:self.f.fightingState];
}

- (void)moveTouch:(CGPoint)l {
    self.f.playerTouch = l;
}

@end
