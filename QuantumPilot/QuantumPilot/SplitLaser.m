#import "SplitLaser.h"
#import "QPBattlefield.h"
#import "SplitLaserCannon.h"

@implementation SplitLaser

//static float segmentWidth = 6; //iPad: 6
//static float segmentHeight = 8; //iPad: 8
//static float segmentSpacing = 10; //iPad: 10

static float halfSegment = 1.5;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    if (self) {
        _xDirection = self.vel.x < 0 ? -1 : 1;
        _yDirection = [self yDirection];
    }
    
    return self;
}

- (void)draw {
    [SplitLaserCannon setDrawColor];
    lines[0] = ccp(self.l.x + (_xDirection * halfSegment * .25), self.l.y + (_yDirection * halfSegment * .75));
    lines[1] = ccp(self.l.x - (_xDirection * halfSegment * .25), self.l.y - (_yDirection * halfSegment * .75));
    
    ccDrawPoly(lines, 2, true);
}



@end
