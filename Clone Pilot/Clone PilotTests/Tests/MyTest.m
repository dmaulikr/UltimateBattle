//
//  MyTest.m
//  MyTestable
//
//  Created by Gabriel Handford on 7/16/11.
//  Copyright 2011 rel.me. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h> 
#import "BulletHellBattlefieldTest.h"

@interface MyTest : GHTestCase { }
@end

@implementation MyTest

- (void)testFoo {
    GHAssertEqualObjects(@"", @"", @"");
}


@end