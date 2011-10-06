//
//  Turn.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/4/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "Turn.h"


@implementation Turn
@synthesize vel;

- (NSString *)description {
    return [NSString stringWithFormat:@"vel:%.5f%.5f",vel.x,vel.y];
}

@end