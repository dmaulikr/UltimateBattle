#import "QPCloneShip.h"

@implementation QPCloneShip

- (void)draw {
    if (self.living > 0) {
        if (self.weapon) {
            [self.weapon setDrawColor];
        } else {
            glColor4f(1, 1, 1, 1.0);
        }
        CGPoint lines[4];
        lines[0] = ccp(self.l.x-16,self.l.y);
        lines[1] = ccp(self.l.x,self.l.y+10);
        lines[2] = ccp(self.l.x+16,self.l.y);
        lines[3] = ccp(self.l.x,self.l.y-37);
        
        drawShapeFromLines(lines, 0, 4);
    }
}


- (NSInteger)identifier {
    return 1;
}

@end
