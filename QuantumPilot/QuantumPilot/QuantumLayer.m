//
//  QuantumLayer.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumLayer.h"
#import "SingleLaser.h"
#import "TriLaser.h"

@implementation QuantumLayer
@synthesize f = _f;
@synthesize metronome = _metronome;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	QuantumLayer *layer = [QuantumLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
    if (self){
        self.f = [QPBattlefield f];
        [self addChild:self.f];
        SingleLaser *l = [[SingleLaser alloc] init];
        [self.f addChild:l];
        l.l = ccp(400,400);
        TriLaser *tl = [[TriLaser alloc] init];
        tl.yDirection = -1;
        tl.l = ccp(500, 400);
        [self.f addChild:tl];

        TriLaser *tl2 = [[TriLaser alloc] init];
        tl2.yDirection = 1;
        tl2.l = ccp(600, 400);
        [self.f addChild:tl2];
        
        self.metronome = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(tick) userInfo:nil repeats:YES];

    }
    return self;
}

- (void)tick {
    [self.f tick];
}

@end
