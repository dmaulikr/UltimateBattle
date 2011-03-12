//
//  Bullet.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface Bullet : GameObject {

}


-(id)initWithYFacing:(int)facing;

+(NSArray *)newBulletsWithYFacing:(int)facing;


@end
