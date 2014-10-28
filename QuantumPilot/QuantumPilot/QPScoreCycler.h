//
//  QPScoreCycler.h
//  QuantumPilot
//
//  Created by quantum on 27/10/2014.
//
//

#import <Foundation/Foundation.h>

@interface QPScoreCycler : NSObject {
    int s;
    int ds;
}

- (void)score:(int)score;

- (void)reset;

- (int)actualScore;

- (int)displayedScore;

- (void)addScoring:(NSDictionary *)d;

- (void)pulse;

@end
