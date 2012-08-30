#import "QPBattlefield.h"

@implementation QPBattlefield
@synthesize currentState = _currentState;
@synthesize titleState = _titleState;

- (void)setupStates {
    self.currentState = [[[QPBFState alloc] init] autorelease];
    self.titleState = [[[QPBFTitleState alloc] init] autorelease];
    self.currentState = self.titleState;
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self = [super initWithLayer:quantumLayer];
    [self setupStates];
    return self;
}

- (void)dealloc {
    [_currentState release];
    [_titleState release];
    [super dealloc];
}

@end
