//
//  Weapon.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 Anthony Broussard. All rights reserved.
//

#import "Weapon.h"
#import "cocos2d.h"

@implementation Weapon

+ (float)speed {
    return [self defaultSpeed];
}

+ (NSArray *)newBullets {
    return nil;
}

+ (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    return nil;
}

+ (NSString *)description {
    return NSStringFromClass([self class]);    
}

- (NSString *)description {
    return [[self class] description];
}

+ (float)defaultSpeed {
    return 2.4; //phone: 3.91 //10, //ipad: 6.8
}

+ (void)setDrawColor {
    ccDrawColor4F(1, 1, 1, 1.0);
}

@end