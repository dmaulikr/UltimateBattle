//
//  QPClonePlayerShip.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 2/11/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPShip.h"

@interface QPClonePlayerShip : QPShip {
    CGPoint lines[4];
}

- (BOOL)shipHitByBullet:(Bullet *)b;

@end
