#import "QPBFTitleState.h"
#import "QPBattlefield.h"

@implementation QPBFTitleState

- (void)activate:(NSDictionary *)options {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:160], @"y" : [NSNumber numberWithInteger:50], @"text" : @"QUANTUM PILOT"}];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubtitleLabel" object:@{@"x":[NSNumber numberWithInteger:160], @"y" : [NSNumber numberWithInteger:75], @"text" : @"You are your own worst enemy"}];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f touchingPlayer:l]) {
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f changeState:self.f.drawingState withTouch:l];
    } else {
        self.f.pilot.autofire = !self.f.pilot.autofire;
    }
}

- (void)deactivate {
    
}

@end
