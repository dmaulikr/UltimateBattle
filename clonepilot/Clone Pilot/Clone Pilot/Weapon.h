//
//  Weapon.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weapon : NSObject <NSCopying> {
    
}

@property (nonatomic, assign) float speed;

- (NSArray *)newBullets;

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction;

+ (float)defaultSpeed;

- (NSString *)weaponImagePath;

@end
