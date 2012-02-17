#import "VRDrawHelpers.h"

void drawShapeFromLines(CGPoint *lines, NSInteger index, NSInteger length) {
    if (index < length -1 ) {
        ccDrawLine(lines[index], lines[index+1]);
        drawShapeFromLines(lines, index+1, length);
    } else {
        ccDrawLine(lines[index], lines[0]);
    }
}