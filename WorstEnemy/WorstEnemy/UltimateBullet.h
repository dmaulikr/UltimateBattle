//
//  UltimateBullet.h
//  WorstEnemy
//
//  Created by Anthony Broussard on 4/22/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicBulletParticles.h"

@interface UltimateBullet : NSObject {

}

@property(nonatomic) CGPoint l;
@property(nonatomic, retain) id particles;

-(void)createParticles;

@end
