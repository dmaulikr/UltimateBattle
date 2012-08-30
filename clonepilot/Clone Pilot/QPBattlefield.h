#import "ClonePilotBattlefield.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"

@interface QPBattlefield : ClonePilotBattlefield

@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@end
