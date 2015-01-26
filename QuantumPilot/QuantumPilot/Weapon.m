//
//  Weapon.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 Anthony Broussard. All rights reserved.
//

#import "Weapon.h"
#import "cocos2d.h"
#import "QPBattlefield.h"

@implementation Weapon

static Weapon *instance = nil;

+ (Weapon *)w {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Weapon alloc] init];
        
    });
    
    return instance;
}


+ (float)speed {
    return [[QPBattlefield f] bulletSpeed];
}

- (void)setupSpeed {
    self.speed =  2.2f + (float)((arc4random() % 200) * 0.01f);
    self.speed =  self.speed * 1/3;
}

+ (NSArray *)newBullets {
    return nil;
}

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction charge:(int)charge {
    return nil;
}

+ (NSString *)description {
    return NSStringFromClass([self class]);    
}

- (NSString *)description {
    return [[self class] description];
}

+ (float)defaultSpeed {
    return [[Weapon w] speed];
}

+ (void)setDrawColor {
    ccDrawColor4F(1, 1, 1, 1.0);
}

+ (NSString *)weaponName {
    return @"Weapon";
}

+ (UIColor *)weaponColor {
    return [UIColor greenColor];;
}

+ (float)chargedSpeed:(int)charge {
    return [self speed] + (.20f * charge);
}

@end