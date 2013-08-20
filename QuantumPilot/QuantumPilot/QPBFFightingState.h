#import "QPBFState.h"

@interface QPBFFightingState : QPBFState {
    BOOL _shiftingToDrawing;
    CGPoint _shiftToDrawingTouch;
    BOOL _interruptDrawingPath;
    
    CGPoint _touch;
    CGPoint _oldPilotLocation;
    
    float _held;
    bool _holding;
}

@end
