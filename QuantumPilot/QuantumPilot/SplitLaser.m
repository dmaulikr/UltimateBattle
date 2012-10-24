#import "SplitLaser.h"
#import "QPBattlefield.h"

@implementation SplitLaser

static float segmentWidth = 6;
static float segmentHeight = 8;
static float segmentSpacing = 10;

- (ccColor4F)color {
    return ccc4f(1, .64, 0, 1);
}

- (id)init {
    self = [super init];
    if (self) {
        _breathCharge = 10;
        segmentIndex[1] = 1;
        segmentIndex[2] = 2;
        segmentIndex[3] = 3;
    }
    return self;
}

- (void)draw {
    lines[0] = ccp(self.l.x + (segmentIndex[0] * segmentSpacing), self.l.y);
    lines[1] = ccp(self.l.x + (segmentIndex[1] * segmentSpacing), self.l.y + segmentHeight * 1);
    lines[2] = ccp(self.l.x + (segmentIndex[2] * segmentSpacing), self.l.y + segmentHeight * 2);
    lines[3] = ccp(self.l.x + (segmentIndex[3] * segmentSpacing), self.l.y + segmentHeight * 3);
    lines[4] = ccp(lines[3].x + segmentWidth, lines[3].y);
    lines[5] = ccp(lines[2].x + segmentWidth, lines[2].y);
    lines[6] = ccp(lines[1].x + segmentWidth, lines[1].y);
    lines[7] = ccp(lines[0].x + segmentWidth, lines[0].y);

    //ccDrawPoly(lines, 8, YES);
    ccDrawSolidPoly(lines, 8, [self color]);
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
