#import "TriLaser.h"
#import "QPBattlefield.h"

@implementation TriLaser
@synthesize xDirection = _xDirection;

static float width = 10;
static float height = 5;
static float dropHeight = 5;
static float dropWidth = 10;

- (ccColor4F)color {
    return ccc4f(.8, .2, .2, 1);
}

- (void)draw {
    lines[0] = ccp(self.l.x, self.l.y + rs * dropHeight * self.yDirection);
    lines[1] = ccp(self.l.x - width, self.l.y - height * self.yDirection);
    lines[2] = ccp(self.l.x - dropWidth, self.l.y - (height * self.yDirection) - (rs * dropHeight * self.yDirection));
    lines[3] = ccp(self.l.x, self.l.y - rs * dropHeight * self.yDirection);
    lines[4] = ccp(self.l.x + dropWidth, self.l.y - (height * self.yDirection) - (rs * dropHeight * self.yDirection));
    lines[5] = ccp(self.l.x + width, self.l.y - height * self.yDirection);
    
    ccDrawSolidPoly(lines, 6, [self color]);
}

@end
