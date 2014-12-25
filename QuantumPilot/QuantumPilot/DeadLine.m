//
//  DeadLine.m
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "DeadLine.h"
#import "cocos2d.h"
#import "QPBattlefield.h"

@implementation DeadLine

- (id)init {
    self = [super init];
    if (self) {
        self.speed = [self defaultSpeed];;
        [self reset];
    }
    return self;
}

- (float)defaultSpeed {
    return -.5;
}

- (int)delayReset {
    return 400;
}

- (void)reset {
    float height = [[UIScreen mainScreen] bounds].size.height;
    self.y = height + 1;
    self.delay = [self delayReset];
}

- (void)pulse {
    if (self.delay > 0) {
        self.delay--;
    } else {
        self.y += self.speed;
    }
}

- (void)draw {
    ccDrawColor4F(1, 0, 0, 1.0);
    ccDrawLine(ccp(0,self.y), ccp(320,self.y));
}

+ (void)setDrawColor {
    ccDrawColor4F(1, 0, 0, 1);
}

@end
