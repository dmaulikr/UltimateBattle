//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"

@implementation QuantumClone
@synthesize history = _history;

- (BOOL)isFiring {
    return self.history.fireTimings[self.history.timeIndex];
}



@end
