//
//  QuantumLayer.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumLayer.h"

@implementation QuantumLayer
@synthesize f = _f;
@synthesize breath = _breath;

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
        
        self.breath = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(breathe) userInfo:nil repeats:YES];

    }
    return self;
}

- (void)breathe {
    [self.f pulse];
}

@end
