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
@synthesize speed;

- (id)init {
    self = [super init];
    if (self) {
        self.speed = [[self class] defaultSpeed];
    }
    return self;
}

- (NSArray *)newBullets {
    return nil;
}

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    return nil;
}

+ (NSString *)description {
    return NSStringFromClass([self class]);    
}

- (NSString *)description {
    return [[self class] description];
}

+ (float)defaultSpeed {
    return 6.8; //10, //6.8
}

-(id)copyWithZone:(NSZone *)zone {
    id another = [[[self class] alloc] init];
    ((Weapon *)another).speed = self.speed;
    return another;
}

- (void)setDrawColor {
    ccDrawColor4F(1, 1, 1, 1.0);
}

@end