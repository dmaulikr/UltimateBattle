//
//  Weapon.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 Anthony Broussard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weapon : NSObject <NSCopying> {
    
}

@property (nonatomic) float speed;

+ (NSArray *)newBullets;

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction;

+ (float)defaultSpeed;
+ (float)speed;
- (void)setupSpeed;

+ (void)setDrawColor;

+ (Weapon *)w;

@end
