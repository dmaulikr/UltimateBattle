#import "QPBFTitleState.h"
#import "QPBattlefield.h"

@implementation QPBFTitleState

- (void)activate:(NSDictionary *)options {
    [super activate:options];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:12], @"text" : @"QUANTUM PILOT"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponLabel" object:[NSNumber numberWithInteger:-1]];
    [self.f resetLineXDirection:1];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f touchingPlayer:l]) {
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f changeState:self.f.drawingState withTouch:l];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SubtitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScorePulse" object:@"title"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScoreLabel" object:@"0"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyPulse" object:@"title"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PathsPulse" object:@"title"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeedLabel" object:@""];
        
        [self.f.pilot announceWeapon];
        [self.f resetScoringTotals];
        
        [self.f resetLineXDirection:-1];
    }
    
    [self.f restGuideMode];
}

- (void)deactivate {
    
}


@end
