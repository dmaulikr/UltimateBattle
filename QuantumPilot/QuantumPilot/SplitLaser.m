#import "SplitLaser.h"
#import "QPBattlefield.h"
#import "SplitLaserCannon.h"

@implementation SplitLaser

static float segmentWidth = 6; //iPad: 6
static float segmentHeight = 8; //iPad: 8
static float segmentSpacing = 10; //iPad: 10

static float halfSegment = 1.5;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    if (self) {
        _breathCharge = 10;
        segmentIndex[1] = 1;
        segmentIndex[2] = 2;
        segmentIndex[3] = 3;
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

- (void)pulse {
    [super pulse];
    _heldBreaths++;
    if (_heldBreaths >= _breathCharge) {
        _heldBreaths = 0;
        segmentIndex[0]++;
        segmentIndex[1]--;
        segmentIndex[2]++;
        segmentIndex[3]--;
        if (segmentIndex[0] > 3) {
            segmentIndex[0] = 0;
        }
        if (segmentIndex[2] > 3) {
            segmentIndex[2] = 0;
        }
        if (segmentIndex[1] < 0) {
            segmentIndex[1] = 3;
        }
        if (segmentIndex[3] < 0) {
            segmentIndex[3] = 3;
        }
    }
}


@end
