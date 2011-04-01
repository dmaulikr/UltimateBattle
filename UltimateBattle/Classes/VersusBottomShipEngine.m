//
//  VersusBottomShipEngine.m
//  ultimatebattle
//
//  Created by Anthony Broussard on 3/18/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "VersusBottomShipEngine.h"


@implementation VersusBottomShipEngine

-(id)init {
    self = [super init];
    if (self) {
        self.movementBounds = CGRectMake(10, 1024-300, 764, 290);
    }
    return self;
}


@end
