//
//  QPScoreCycler.m
//  QuantumPilot
//
//  Created by quantum on 27/10/2014.
//
//

#import "QPScoreCycler.h"
#import "QPBFScoreState.h"

@implementation QPScoreCycler

- (void)score:(int)score {
    s+= score;
}

- (void)reset {
    ds = 0;
    s = 0;
}

- (void)pulse {
    if (s > 0) {
        if (s > 999) {
            s-= 999;
            ds+=999;
        }
        
        if (s > 99) {
            s-= 99;
            ds+= 99;
        }
        
        if (s > 0) {
            s--;
            ds++;
        }
    }
}

- (NSInteger)actualScore {
    return ds + s;
}

- (NSInteger)displayedScore {
    return ds;
}

//- (void)addScoring:(NSDictionary *)d {
//    int time        = [d[QP_BF_TIMESCORE] intValue];
//    int accuracy    = [d[QP_BF_ACCSCORE] intValue];
//    int pathing     = [d[QP_BF_PATHSCORE] intValue];
//    ds              = [d[QP_BF_SCORE] intValue];
//    s+= time;
//    s+= accuracy;
//    s+= pathing;
//}

@end
