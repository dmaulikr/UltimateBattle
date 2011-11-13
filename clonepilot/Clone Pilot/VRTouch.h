//
//  VRTouch.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 11/13/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRTouch : NSObject

@property (nonatomic, assign) CGPoint l;

- (id)initWithLocation:(CGPoint)location;

@end