#import "QPBFState.h"

@interface QPBFFightingState : QPBFState {
    BOOL _shiftingToDrawing;
    CGPoint _shiftToDrawingTouch;
    BOOL _interruptDrawingPath;
}

@end
