//
//  VersusTopShipEngine.m
//  ultimatebattle
//
//  Created by Anthony Broussard on 3/18/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "VersusTopShipEngine.h"


@implementation VersusTopShipEngine

-(id)init {
    self = [super init];
    if (self) {
        self.movementBounds = CGRectMake(10, 10, 764, 300);
    }
    return self;
}


@end
