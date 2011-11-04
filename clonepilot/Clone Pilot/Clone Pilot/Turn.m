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
@synthesize firing;

- (NSString *)mirrorDescription {
    float x = vel.x;
    
    float y = 0;
    if (fabsf(vel.y) > 0) {
        y = -vel.y;
    }
    return [NSString stringWithFormat:@"vel:x:%.5f y:%.5f firing:%d",x,y,firing];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"vel:x:%.5f y:%.5f firing:%d",vel.x,vel.y,firing];
}



// In the implementation
-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    Turn *another = [[Turn alloc] init];
    another.vel = self.vel;
    another.firing = self.firing;
    
    return another;
}


@end