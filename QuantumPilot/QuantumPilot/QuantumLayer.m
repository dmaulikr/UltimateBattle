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
        [self.f addChild:tl];
        tl.l = ccp(500, 400);
        self.metronome = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(tick) userInfo:nil repeats:YES];

    }
    return self;
}

- (void)tick {
    [self.f tick];
}

@end
