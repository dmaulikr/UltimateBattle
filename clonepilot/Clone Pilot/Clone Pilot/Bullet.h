//
//  Bullet.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRBoundaryFrame.h"

@interface Bullet : NSObject {
    
}

@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) BOOL finished;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity;

- (void)tick;

+ (Bullet *)sampleBullet;

@end
