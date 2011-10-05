//
//  ClonePlayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"

@interface ClonePlayer : NSObject <VRGameObject> {
    
}

- (id)initWithLocation:(CGPoint)location;

+ (ClonePlayer *)samplePlayer;

- (void)tick;

@end
