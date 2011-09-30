//
//  BulletHellBattlefieldTest.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 9/29/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "BulletHellBattlefieldTest.h"
#import "BulletHellBattlefield.h"

@implementation BulletHellBattlefieldTest



- (void)testInit {
    BulletHellBattlefield *field = [BulletHellBattlefield field];    
    GHAssertEqualObjects(field.bullets, [NSMutableArray array], @"Battlefield should have an empty array of bullets");
}

@end
