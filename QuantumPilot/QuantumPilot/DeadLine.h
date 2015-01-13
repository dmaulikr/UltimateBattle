//
//  DeadLine.h
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "CCNode.h"

@interface DeadLine : CCNode {
    int _width;
}

@property (nonatomic) float y;
@property (nonatomic) float speed;
@property (nonatomic) int delay;

- (void)pulse;
- (void)reset;

@end
