//
//  ClonePilot.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"

@interface ClonePilot : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, assign) BOOL living;

@end