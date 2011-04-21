//
//  Bullet.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cmpgames.h"
#import "cocos2d.h"
#import "BulletProtocol.h"

@interface WBullet : NSObject <BulletProtocol> {
    
}

-(id) initWithStart:(CGPoint) start;

@end
