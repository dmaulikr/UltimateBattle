#import "QPDrawing.h"

CGPoint* basicDiamondShipLines(CGPoint l, NSInteger yDir) {
    lines[0] = ccp(l.x-16,l.y);
    lines[1] = ccp(l.x,l.y+(yDir *10));
    lines[2] = ccp(l.x+16,l.y);
    lines[3] = ccp(l.x,l.y-(yDir * 37));
    return lines;
}

void drawBasicDiamondShip(CGPoint l, NSInteger yDir) {
    ccDrawPoly(basicDiamondShipLines(l, yDir), 4, YES);    
}
