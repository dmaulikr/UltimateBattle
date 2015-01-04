//
//  QPScoreCycler.h
//  QuantumPilot
//
//  Created by quantum on 27/10/2014.
//
//

#import <Foundation/Foundation.h>

@interface QPScoreCycler : NSObject {
    NSInteger s;
    NSInteger ds;
}

- (void)score:(int)score;

- (void)scoreBonus:(int)bonus;

- (void)reset;

- (NSInteger)actualScore;

- (NSInteger)displayedScore;

//- (void)addScoring:(NSDictionary *)d;

- (void)pulse;
- (void)updateScore;

@end
