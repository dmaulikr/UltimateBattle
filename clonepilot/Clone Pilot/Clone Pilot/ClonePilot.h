//
//  ClonePilot.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"
#import "Weapon.h"

@interface ClonePilot : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, assign) BOOL living;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) NSInteger moveIndex;

+ (CGPoint)defaultLocation;
+ (NSInteger)identifier;

- (void)tick;
- (void)reset;

@end