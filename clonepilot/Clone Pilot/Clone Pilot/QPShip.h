#import <Foundation/Foundation.h>
#import "Weapon.h"
#import "VRGameObject.h"
#import "BulletDelegateProtocol.h"
#import "VRDrawHelpers.h"

@interface QPShip : CCNode <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) NSInteger health;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, retain) NSArray *lastBulletsFired;
@property (nonatomic, assign) NSInteger weaponDirection;

//- (CGPoint *)lines;

- (NSInteger)identifier;

- (void)fire;
- (BOOL)living;

@end
