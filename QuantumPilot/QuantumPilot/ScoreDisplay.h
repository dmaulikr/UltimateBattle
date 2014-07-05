//
//  ScoreDisplay.h
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "CCNode.h"

@interface ScoreDisplay : CCNode {
    int iteration;
    CGPoint vertexes[4];
    CGPoint l;
}

- (int)iteration;

- (void)pulse;

@end
