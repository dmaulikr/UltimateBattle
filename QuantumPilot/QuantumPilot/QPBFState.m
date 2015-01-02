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

- (void)pulse {
    
}

- (void)postTick {
    
}

- (void)addTouch:(CGPoint)l {

}

- (void)addDoubleTouch {
    
}

- (void)endTouch:(CGPoint)l {
    
}

- (void)moveTouch:(CGPoint)l {
    
}

- (void)resetFireCircle {
    [self.f moveFireCircleOffscreen];
}

- (void)activate:(NSDictionary *)options {
    [self resetFireCircle];
}

- (void)deactivate {
    
}


- (BOOL)isPulsing {
    return NO;
}

- (void)dealloc {
    self.f = nil;
    [super dealloc];
}

- (bool)isShieldDebrisPulsing {
    return false;
}

@end
