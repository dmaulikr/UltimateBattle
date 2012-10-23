#import "QuadLaser.h"
#import "QPBattlefield.h"

@implementation QuadLaser
@synthesize xDirection = _xDirection;

static float outerWidth = 10;
static float outerHeight = 20;

- (ccColor4F)color {
    return ccc4f(.05, .05, .9, 1);
}

- (void)draw {
    CGPoint lines[4];
    lines[0] = ccp(self.l.x, self.l.y);
    lines[1] = ccp(self.l.x - outerWidth * self.xDirection, self.l.y + pr * outerHeight);
    lines[2] = ccp(self.l.x, self.l.y + outerHeight);
    lines[3] = ccp(self.l.x + outerWidth * self.xDirection, self.l.y + outerHeight - (pr * outerHeight));
    ccDrawSolidPoly(lines, 4, [self color]);
}


@end
