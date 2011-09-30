//
//  BulletHellBattlefield.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 9/29/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "BulletHellBattlefield.h"


@implementation BulletHellBattlefield
@synthesize bullets;

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
    }
    return self;
}

+ (BulletHellBattlefield *)field {
    static BulletHellBattlefield *__BulletHellBattlefield;    
    
    if (!__BulletHellBattlefield) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __BulletHellBattlefield = [[BulletHellBattlefield alloc] init];
        });
    }
    
    return __BulletHellBattlefield;
}

- (void)dealloc {
    [bullets release];
    [super dealloc];
}

@end