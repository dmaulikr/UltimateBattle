//
//  ClonePlayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"
#import "Turn.h"

@interface ClonePlayer : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *currentMoves;

- (id)initWithLocation:(CGPoint)location;

+ (ClonePlayer *)samplePlayer;

- (void)tick;

@end
