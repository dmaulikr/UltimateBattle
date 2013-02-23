#import <Foundation/Foundation.h>
#import "VRGeometry.h"
@class QPBattlefield;

@interface QPBFState : NSObject

@property (nonatomic, assign) QPBattlefield *f;

- (void)pulse;
- (void)postTick;
- (void)addTouch:(CGPoint)l;
- (void)addDoubleTouch;
- (void)endTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;

- (id)initWithBattlefield:(QPBattlefield *)field;

- (BOOL)isPulsing;

@end

