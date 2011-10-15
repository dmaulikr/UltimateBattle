//
//  SingleLaser.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"

@interface SingleLaser : Weapon {
    
}

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction;

@end
