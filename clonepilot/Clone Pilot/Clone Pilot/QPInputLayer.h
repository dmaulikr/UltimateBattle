//
//  QPInputLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/13/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPInputLayer : NSObject

@property (nonatomic, assign) CGPoint l;

- (void)processTouchPoint:(CGPoint)p withArrayOfNextDelegates:(NSArray *)delegates;

@end
