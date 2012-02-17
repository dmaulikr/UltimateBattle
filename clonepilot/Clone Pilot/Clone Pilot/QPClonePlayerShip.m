#import "QPClonePlayerShip.h"

@implementation QPClonePlayerShip

- (NSInteger)identifier {
    return 0;
}

- (void)draw {
    if (self.living) {
        glColor4f(1, 1, 1, 1.0);
        CGPoint lines[4];
        lines[0] = ccp(self.l.x-16,self.l.y);
        lines[1] = ccp(self.l.x,self.l.y+37);
        lines[2] = ccp(self.l.x+16,self.l.y);
        lines[3] = ccp(self.l.x,self.l.y-10);
        
        drawShapeFromLines(lines, 0, 4);
    }
}

@end
