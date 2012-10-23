//
//  Bullet.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "CCNode.h"
#import "QPShortcuts.h"
#import "cocos2d.h"

@class QPBattlefield;

@interface Bullet : CCNode

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSInteger yDirection;

@end
