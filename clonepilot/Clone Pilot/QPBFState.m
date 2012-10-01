#import "QPBFState.h"
#import "QPBattlefield.h"

@implementation QPBFState
@synthesize f = _f;

- (id)initWithBattlefield:(QPBattlefield *)field {
    self = [super init];
    if (self) {
        self.f = field;
    }
    
    return self;
}

- (void)tick {
    
}

- (void)postTick {
    
}

- (void)addTouch:(CGPoint)l {

}

- (void)endTouch:(CGPoint)l {
    
}

- (void)moveTouch:(CGPoint)l {
    
}

- (void)dealloc {
    [_f release];
    [super dealloc];
}

@end
