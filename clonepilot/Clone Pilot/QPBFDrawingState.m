#import "QPBFDrawingState.h"
#import "QPBattlefield.h"

@implementation QPBFDrawingState

- (void)addTouch:(CGPoint)l {
    float xOffset = l.x - self.f.player.l.x;
    float yOffset = l.y - self.f.player.l.y;
    self.f.touchPlayerOffset = ccp(xOffset, yOffset);
}

@end
