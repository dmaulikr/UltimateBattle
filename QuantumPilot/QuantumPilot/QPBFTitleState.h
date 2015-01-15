#import "QPBFState.h"
#import "VRGeometry.h"

@interface QPBFTitleState : QPBFState {
    int _timer;
    bool _showingScore;
}

- (bool)showingScore;

@end
