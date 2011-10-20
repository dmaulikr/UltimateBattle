//
//  Weapon.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon
@synthesize speed;

- (id)init {
    self = [super init];
    if (self) {
        self.speed = [[self class] defaultSpeed];
    }
    return self;
}

- (NSArray *)newBullets {
    return [NSArray array];
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

+ (float)defaultSpeed {
    return 3;
}

-(id)copyWithZone:(NSZone *)zone {
    // We'll ignore the zone for now
    Weapon *another = [[Weapon alloc] init];
    another.speed = self.speed;
    return another;
}


@end