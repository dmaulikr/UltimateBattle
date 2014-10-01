//
//  Arsenal.m
//  QuantumPilot
//
//  Created by quantum on 01/10/2014.
//
//

#import "Arsenal.h"

@implementation Arsenal

+ (NSArray *)arsenal {
    return @[@"SingleLaserCannon", @"SplitLaserCannon", @"FastLaserCannon", @"TightSpiralLaserCannon", @"WideTriLaserCannon", @"QuadLaserCannon", @"WideSpiralLaserCannon"];
}

+ (NSArray *)upgradeArsenal {
    return [[self arsenal] subarrayWithRange:    NSMakeRange(2, [[self arsenal] count] - 2)];

    
}

+ (Class)weaponIndexedFromArsenal:(int)i {
    return NSClassFromString([self arsenal][i]);
}

@end
