//
//  QuantumPilot.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumPilot.h"

@implementation QuantumPilot
@synthesize n;

+(int (*)[10][10])returnArray {
    int (*array)[10][10] = malloc(10 * 10 * sizeof(int));
    return array;
}

// return a ructure

+(struct array)returnArray2 {
    struct array a;
    a.array[2][9] = 5;
    return a;
}

- (void)setWaypoint:(CGPoint)l index:(NSInteger)index {
    self.n.waypoints[index] = l;
    _nav.waypoints[index] = l;
}

- (struct course)navigationCourse {
    return _nav;
}

@end
