//
//  QPTouchPointInputLayerHandler.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPInputHandler.h"

@interface QPTouchPointInputLayerHandler : NSObject

@property (nonatomic, retain) NSMutableArray *handlers;

- (void)addHandler:(QPInputHandler *)handler;

- (void)execute;

@end
