#import "QPBFTitleState.h"
#import "QPBattlefield.h"

@implementation QPBFTitleState

- (void)activate:(NSDictionary *)options {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:54], @"text" : @"QUANTUM PILOT"}];

}

- (void)addTouch:(CGPoint)l {
    if ([self.f touchingPlayer:l]) {
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f changeState:self.f.drawingState withTouch:l];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SubtitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
    } else if ([self.f touchingFireCircle:l]) {
        [self.f.pilot fire];
        [self.f changeState:self.f.fightingState withTouch:l];

    }
}

- (void)deactivate {
    
}

@end
