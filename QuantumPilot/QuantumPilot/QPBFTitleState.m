#import "QPBFTitleState.h"
#import "QPBattlefield.h"

@implementation QPBFTitleState

- (void)activate:(NSDictionary *)options {
    [super activate:options];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:12], @"text" : @"QUANTUM PILOT"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponLabel" object:[NSNumber numberWithInteger:-1]];
    [self.f resetLineXDirection:1];
    [self resetTimer];
    _showingScore = false;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSocial" object:@""];
}

- (void)announceLabels {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSocial" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubtitleLabel" object:@{@"x":[NSNumber numberWithInteger:    [[UIScreen mainScreen] bounds].size.width / 2], @"y" : [NSNumber numberWithInteger:-5000], @"text" : @"QUANTUM PILOT"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScorePulse" object:@"title"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScoreLabel" object:@"0"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AccuracyPulse" object:@"title"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PathsPulse" object:@"title"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeedLabel" object:@""];
}

- (void)start:(CGPoint)l {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSocial" object:nil];
    [self.f setTouchOffsetFromPilotNear:l];
    [self.f changeState:self.f.drawingState withTouch:l];
    [self announceLabels];
    [self.f.pilot announceWeapon];
    [self.f resetScoringTotals];
    [self.f resetLineXDirection:-1];
}

- (void)addTouch:(CGPoint)l {
    float yLimit = [[UIScreen mainScreen] bounds].size.height;
    float y2Limit = yLimit;
    yLimit  = yLimit * 2/3;
    y2Limit = y2Limit * 1/3;
    if ([self.f touchingPlayer:l]) {
        [self start:l];
    } else if (l.y > yLimit) {
        [self handleTopTap:l.x];
    } else if (l.y > y2Limit) {
        [self start:l];
    }
    
    [self.f restGuideMode];
}

- (void)handleTopTap:(float)x {

}

- (void)resetTimer {
    _timer = 80;
}

- (void)pulse {
//    _timer --;
//    if (_timer <= 0) {
//        [self resetTimer];
//        _showingScore = !_showingScore;
//        if (_showingScore) {
//            [self.f announceScores];
//        } else {
//            if ([self.f showSocial]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSocial" object:@""];
//            }
//        }
//    }
}

- (bool)showingScore {
    return _showingScore;
}

@end
