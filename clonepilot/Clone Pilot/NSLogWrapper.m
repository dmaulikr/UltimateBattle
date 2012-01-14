//
//  NSLogWrapper.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "NSLogWrapper.h"

@implementation NSLogWrapper

- (int)log:(NSString *)logString {
    NSLog(@"%@", logString);
    return 1;
}

@end
