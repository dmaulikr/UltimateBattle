//
//  QPBattlefield.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QPBattlefield.h"

@implementation QPBattlefield
@synthesize rhythmScale = _rhythmScale;
@synthesize rhythmDirection = _rhythmDirection;

static QPBattlefield *instance = nil;

+ (QPBattlefield *)f {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPBattlefield alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.rhythmGrowth = .01;
        self.rhythmDirection = 1;
    }
    return self;
}

+ (float)rhythmScale {
    QPBattlefield *battlefield = [QPBattlefield f];
    return [battlefield rhythmScale];
}

- (void)tick {
    self.rhythmScale+= self.rhythmGrowth * self.rhythmDirection;
    if (self.rhythmScale >= 1) {
        self.rhythmScale = 1;
        self.rhythmDirection = -1;
    } else if (self.rhythmScale < .5) {
        self.rhythmScale = .5;
        self.rhythmDirection = 1;
    }
}

@end
