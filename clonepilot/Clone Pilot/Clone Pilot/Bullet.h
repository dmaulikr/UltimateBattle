//
//  Bullet.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bullet : NSObject {
    
}

@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) CGPoint l;

- (id)initWithVelocity:(CGPoint)velocity;

- (void)tick;

@end
