#import <Foundation/Foundation.h>
#import "VRGeometry.h"
@class QPBattlefield;

@interface QPBFState : NSObject

@property (nonatomic, retain) QPBattlefield *f;

- (void)addTouch:(CGPoint)l;

- (id)initWithBattlefield:(QPBattlefield *)field;

@end
