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
@synthesize freshClone          = _freshClone;

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

- (void)setupClone {
//    self.newClone = [[QuantumClone alloc] initWithLayer:]
}

- (id)initWithLayer:(CCLayer *)quantumLayer {
    self = [super initWithLayer:quantumLayer];
    [self setupStates];
    [self setupClone];
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
    NSLog(@"%d", self.drawingIteration);
    glColor4f(1, 1, 1, 1.0);
    CGPoint drawingDeltas[4001];
    NSInteger index = 0;
    for (int i = self.fightingIteration; i < self.drawingIteration; i++) {
        drawingDeltas[index] = _deltas[i];
        index++;
    }
    NSInteger drawFrameTotal = self.drawingIteration - self.fightingIteration;
    if (drawFrameTotal < 0) {
        drawFrameTotal = 0;
    }
    ccDrawPoly(drawingDeltas, drawFrameTotal, NO);
}

- (void)tick {
    [self.currentState tick];
    self.lastPlayerTouch = self.playerTouch;
    [self.pilot tick];
    [self.currentState postTick];
}

- (void)resetIterations {
    self.drawingIteration = 0;
    self.fightingIteration = 0;
}

- (void)resetPassedIterations {
    //shift each iteration down..
//    NSInteger iteration = self.fightingIteration;
//    for (int j = self.fightingIteration; j  < self.drawingIteration; j++) {
//    for (int i = self.fightingIteration; i < self.drawingIteration; i++) {
//        _deltas[i] = _deltas[i++];
//    }
//    }
//    
//    [self resetIterations];
//    self.drawingIteration = iteration;
}


- (void)clearAllDeltas {
    for (int i = 0; i < self.drawingIteration; i++) {
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
    if (self.time < QPBF_MAX_DRAWING_FRAMES) {
        _deltas[self.drawingIteration] = delta;
        self.latestExpectedX = delta.x;
        self.latestExpectedY = delta.y;
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

- (void)advanceLevel {
    //spawn clone
}


- (void)pilotFires {
    [self.player fire];
    [self addFireDelta];
}

- (void)activateFreshClone {
    
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