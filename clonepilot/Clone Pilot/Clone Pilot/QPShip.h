#import <Foundation/Foundation.h>
#import "Weapon.h"
#import "VRGameObject.h"
#import "BulletDelegateProtocol.h"
#import "VRDrawHelpers.h"
#import "QPDrawing.h"
#import "VRGeometry.h"

extern int historicalTurnsCount;

@interface QPShip : CCNode <VRGameObject> {
    CGPoint historicalPoints[51];
}

@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) BOOL living;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, retain) NSArray *lastBulletsFired;
@property (nonatomic, assign) NSInteger weaponDirection;

- (NSInteger)identifier;

- (void)tick;
- (void)fire;
- (BOOL)living;
- (CGPoint)defaultLocation;
- (NSInteger)yDirection;
- (void)clearHistoricalPoints;
- (void)setDrawingColor;

@end
