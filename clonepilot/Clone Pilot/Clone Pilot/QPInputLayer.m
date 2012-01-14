//
//  QPInputLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/13/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPInputLayer.h"
#import "VRGeometry.h"

@implementation QPInputLayer
@synthesize l;

- (CGRect)hitbox {
    return CGRectMake(self.l.x, 
                      self.l.y, 1,
                      1);
}

- (CGPoint)failResponse {
    return CGPointZero;
}

- (CGPoint)processedResult:(CGPoint)p {
    if (CGRectContainsPoint([self hitbox], p)) {
        return GetAngle(self.l, p);
    }
    
    return [self failResponse];
}

- (void)processTouchPoint:(CGPoint)p withArrayOfNextDelegates:(NSArray *)delegates{
//    CGPoint processed = [self processedResult:p];
//    if (CGPointEqualToPoint(processed, [self failResponse])) {
//        QPInputLayer *immediateNextLayer = [delegates objectAtIndex:0];
//        NSMutableArray *nextLayers = [[NSMutableArray arrayWithArray:delegates] copy];
//        if ([nextLayers count] > 0) {
//            [nextLayers removeObject:immediateNextLayer];
//            [immediateNextLayer processTouchPoint:p withArrayOfNextDelegates:nextLayers];
//        }
//    }
         
    //send processed touch  

//    NSLog(@"result: %d", 1&0);
//    int result = 1&0;
//    [self.delegate shareArbitraryValue:foo];

}

//- (BOOL)processedTouchPointAdded:(CGPoint)p {
//    if (CGRectContainsPoint([self hitbox], p)) {
//        [self processTouchPoint:p nextDelegate:];
//        return YES;
//    }
//    
//    return NO;
//}

@end
