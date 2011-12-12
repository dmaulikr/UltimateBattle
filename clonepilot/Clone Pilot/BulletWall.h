//
//  BulletWall.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/7/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"
#import "VRGameObject.h"

@interface BulletWall : NSObject <VRGameObject>


- (void)tick;
- (void)reset;

- (id)initWithLayer:(CCLayer *)layer;

@end
