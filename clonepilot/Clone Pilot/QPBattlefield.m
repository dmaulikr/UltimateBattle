#import "QPBattlefield.h"

@implementation QPBattlefield
@synthesize currentState        = _currentState;
@synthesize titleState          = _titleState;
@synthesize drawingState        = _drawingState;
@synthesize fightingState       =_fightingState;
@synthesize cloningState        = _cloningState;
@synthesize scoringState        = _scoringState;
@synthesize weaponSelectionState = _weaponSelectionState;
@synthesize playerTouch         = _playerTouch;
@synthesize lastPlayerTouch     = _lastPlayerTouch;
@synthesize touchPlayerOffset   = _touchPlayerOffset;
@synthesize pausedState         = _pausedState;
@synthesize drawingIteration    = _drawingIteration;
@synthesize fightingIteration   = _fightingIteration;
@synthesize latestExpectedX     = _latestExpectedX;
@synthesize latestExpectedY     = _latestExpectedY;
@synthesize pauses              = _pauses;
@synthesize drawFrame           = _drawingFrame;

- (void)setupStates {
    self.currentState   = [[[QPBFState alloc] initWithBattlefield:self] autorelease];
    self.titleState     = [[[QPBFTitleState alloc] initWithBattlefield:self] autorelease];
    self.drawingState   = [[[QPBFDrawingState alloc] initWithBattlefield:self] autorelease];
    self.pausedState    = [[[QPBFPausedState alloc] initWithBattlefield:self] autorelease];
    self.fightingState  = [[[QPBFFightingState alloc] initWithBattlefield:self] autorelease];
    self.cloningState   = [[[QPBFCloningState alloc] initWithBattlefield:self] autorelease];
    self.scoringState   = [[[QPBFScoringState alloc] initWithBattlefield:self] autorelease];
    self.weaponSelectionState = [[[QPBFWeaponSelectionState alloc] initWithBattlefield:self] autorelease];
    
    self.currentState = self.titleState;
}

- (void)setupPlayerWithLayer:(CCLayer *)quantumLayer {
    self.player = [[[QuantumPilot alloc] initWithLayer:quantumLayer] autorelease];
    self.player.bulletDelegate = self;
}

- (void)setupWeaponSelector {
    
}
- (void)setupTime {
    
}
- (void)setupInputHandler {
    
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self = [super initWithLayer:quantumLayer];
    [self setupStates];
    [quantumLayer addChild:self];
    return self;
}


- (void)killClone:(ClonePilot *)clone {
    [clone ceaseLiving];
}

- (void)checkForCloneCollision:(Bullet *)b {
    for (ClonePilot *p in self.clones) {
        if (!b.finished && p.living && b.identifier != [ClonePilot identifier]) {
            if ([p shipHitByBullet:b]) {
                [self killClone:p];
                self.hits++;
                b.finished = YES;
            }
        }
    }
}

- (void)bulletLoop {
    for (Bullet *b in self.bullets) {
        [self checkForCloneCollision:b];
    }
    [Bullet bulletLoop:self.bullets];
}

- (void)draw {
    glColor4f(1, 1, 1, 1.0);
    CGPoint drawingDeltas[4001];
//    if (self.currentState == self.fightingState) {
//    NSLog(@"fighting/drawing: %d %d", self.fightingIteration, self.drawingIteration);
    NSInteger index = 0;
    for (int i = self.fightingIteration; i < self.drawingIteration; i++) {
            drawingDeltas[index] = _deltas[i];
        index++;
  //      CGPoint p = drawingDeltas[i];
     //   NSLog(@"i and x : %d %f", i, p.x);
        }
    //CGPoint zeroDrawing = drawingDeltas[0];
   // CGPoint fightingIterationDrawing = drawingDeltas[self.fightingIteration];
  //  NSLog(@"%f %f", zeroDrawing.x, zeroDrawing.y);
//    NSLog(@"%f %f %d", fightingIterationDrawing.x, fightingIterationDrawing.y, self.fightingIteration);
        ccDrawPoly(drawingDeltas, self.drawingIteration - self.fightingIteration, NO);
  //  }
}

- (void)clearFrames {
    for (int i = 0; i < 4001; i++) {
        _active[i] = NO;
    }
}

- (void)addActive {
    _active[self.drawFrame] = YES;
}

- (void)tick {
    [self.currentState tick];
    self.lastPlayerTouch = self.playerTouch;
    [self.pilot tick];
    [self.currentState postTick];
}

- (void)resetDrawingIterationToFighting {
    self.latestExpectedX = self.player.l.x;
    self.latestExpectedY = self.player.l.y;
    self.player.t = self.player.l;
    self.drawingIteration = self.fightingIteration;
}

- (void)clearAllDeltas {
    for (int i = 0; i < self.drawingIteration; i++) {
//        [self setXDelta:0 atIndex:i];
//        [self setYDelta:0 atIndex:i];
        [self setDeltaPoint:self.player.l index:i];
    }
}

- (void)addTouch:(CGPoint)l {
    [self.currentState addTouch:l];
}

- (void)endTouch:(CGPoint)l {
    [self.currentState endTouch:l];
}

- (void)moveTouch:(CGPoint)l {
    [self.currentState moveTouch:l];
}

- (void)changeState:(QPBFState *)state {
    self.currentState = state;
}

- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l {
    [self changeState:state];
    [self.currentState addTouch:l];
}

- (void)setDeltaPoint:(CGPoint)delta index:(NSInteger)index {
    _deltas[index] = delta;
}

- (CGPoint)deltaPoint:(NSInteger)index {
    return _deltas[index];
}

- (void)addDelta:(CGPoint)delta {
    if (self.drawingIteration < QPBF_MAX_DRAWING_FRAMES) {
        _deltas[self.drawingIteration] = delta;
        self.latestExpectedX = delta.x;
        self.latestExpectedY = delta.y;
    }
}

- (float)xDelta:(NSInteger)index {
    return _xDelta[index];
}

- (float)yDelta:(NSInteger)index {
    return _yDelta[index];
}

- (void)addXDelta:(float)delta {
    if (self.drawingIteration < QPBF_MAX_DRAWING_FRAMES) {
        _xDelta[self.drawingIteration] = delta;
        self.latestExpectedX += delta;
    }
}

- (void)addYDelta:(float)delta {
    if (self.drawingIteration < QPBF_MAX_DRAWING_FRAMES) {    
        _yDelta[self.drawingIteration] = delta;
        self.latestExpectedY += delta;
    }
}

- (void)setXDelta:(float)delta atIndex:(NSInteger)index {
    if (index <= self.drawingIteration) {
        _xDelta[index] = delta;
    }
}

- (void)setYDelta:(float)delta atIndex:(NSInteger)index {
    if (index <= self.drawingIteration) {
        _yDelta[index] = delta;
    }
}

- (BOOL)fireDeltaAtIndex:(NSInteger)index {
    return _fireDelta[index];
}

- (void)addFireDelta {
    _fireDelta[self.fightingIteration] = YES;
}

- (CGPoint)latestExpectedPathPoint {
    return ccp(self.latestExpectedX, self.latestExpectedY);
}

- (BOOL)touchingPlayer:(CGPoint)l {
    return GetDistance(l, self.player.l) <= QPBF_PLAYER_TAP_RANGE;
}

- (QuantumPilot *)pilot {
    return (QuantumPilot *)self.player;
}

- (QuantumClone *)newestClone {
    return (QuantumClone *)[self.clones lastObject];
}

- (void)addClone {
    QuantumClone *c = [[QuantumClone alloc] initWithLayer:self.layer];
    [self.clones addObject:c];
    c.bulletDelegate = self;
    [c release];
}


- (void)pilotFires {
    [self.player fire];
    [self addFireDelta];
}

- (void)dealloc {
    [_currentState release];
    [_titleState release];
    [_drawingState release];
    [_pausedState release];
    [_fightingState release];
    [_scoringState release];
    [_weaponSelectionState release];
    
    [super dealloc];
}

@end