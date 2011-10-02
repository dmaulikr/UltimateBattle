//
//  BulletHellBattlefield.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

@interface BulletHellBattlefield : NSObject {
    
}

@property (nonatomic, retain) NSMutableArray *bullets;

- (void)tick;
- (void)addBullet:(Bullet *)b;

@end