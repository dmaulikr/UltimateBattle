//
//  WeaponTest.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "Kiwi.h"
#import "VRGeometry.h"
#import "SingleLaser.h"
#import "Bullet.h"

SPEC_BEGIN(WeaponTest)

describe(@"Weapon", ^{
    __block SingleLaser *w;
    beforeEach(^{
        w = [[[SingleLaser alloc] init] autorelease];
    });
    
    it(@"should collect bullets", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384,300) direction:-1];
        [[theValue([bullets count]) should] beGreaterThan:theValue(0)];
    });
    
    it(@"should match location passed in", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384,300) direction:-1];
        Bullet *b = [bullets lastObject];
        [[theValue(b.l) should] equal:theValue(CGPointMake(384,300))];
    });
    
});

SPEC_END