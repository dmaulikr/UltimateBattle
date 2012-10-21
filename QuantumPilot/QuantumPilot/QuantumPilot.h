//
//  QuantumPilot.h
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "CCNode.h"

struct course {
    CGPoint const[4001];
    BOOL firing[4001];`
};

struct array {
    int array[10][10];
};

@interface QuantumPilot : CCNode {
    struct course _nav;
}

@property (nonatomic) struct course n;

+(struct array)returnArray2;
- (struct course)navigationCourse;
- (void)setWaypoint:(CGPoint)l index:(NSInteger)index;

@end
