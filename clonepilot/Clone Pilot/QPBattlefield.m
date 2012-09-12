#import "QPBattlefield.h"

@implementation QPBattlefield
@synthesize currentState = _currentState;
@synthesize titleState = _titleState;
@synthesize drawingState = _drawingState;
@synthesize touchPlayerOffset = _touchPlayerOffset;

- (void)setupStates {
    self.currentState = [[[QPBFState alloc] initWithBattlefield:self] autorelease];
    self.titleState = [[[QPBFTitleState alloc] initWithBattlefield:self] autorelease];
    self.drawingState = [[[QPBFDrawingState alloc] initWithBattlefield:self] autorelease];
    self.currentState = self.titleState;
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self = [super initWithLayer:quantumLayer];
    [self setupStates];
    return self;
}

- (void)addTouch:(CGPoint)l {
    [self.currentState addTouch:l];
}

- (void)changeState:(QPBFState *)state {
    self.currentState = state;
}

- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l {
    [self changeState:state];
    [self.currentState addTouch:l];
}

- (void)dealloc {
    [_currentState release];
    [_titleState release];
    [_drawingState release];
    [super dealloc];
}

@end
