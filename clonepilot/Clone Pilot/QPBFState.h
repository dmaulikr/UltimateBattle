#import <Foundation/Foundation.h>
#import "VRGeometry.h"
@class QPBattlefield;

@interface QPBFState : NSObject

@property (nonatomic, retain) QPBattlefield *f;

- (void)tick;
- (void)postTick;
- (void)addTouch:(CGPoint)l;
- (void)endTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;

- (id)initWithBattlefield:(QPBattlefield *)field;

@end

