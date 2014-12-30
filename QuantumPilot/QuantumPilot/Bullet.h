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

@protocol BulletDelegate;

@class QPBattlefield;

@interface Bullet : CCNode

@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic) NSInteger identifier;

@property (nonatomic) NSInteger radius;

@property (nonatomic) float drawMultiplier;

@property (strong, nonatomic) NSString *zone;

@property (nonatomic, assign) id <BulletDelegate> delegate;

@property (nonatomic) int crushes;

@property (strong, nonatomic) NSMutableArray *zoneArray;

- (void)pulse;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity;

- (int)yDirection;

- (NSString *)weapon;

- (CGPoint)velocity;

@property (nonatomic) int zx;
@property (nonatomic) int zy;

- (void)crushBullet:(Bullet *)b;

@end

@protocol BulletDelegate <NSObject>

- (void)bulletChangedZone:(Bullet *)b;
- (void)cloneBulletChangedZone:(Bullet *)b;

@end
