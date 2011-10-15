//
//  Weapon.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

- (NSArray *)newBullets {
    return [NSArray array];
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

@end