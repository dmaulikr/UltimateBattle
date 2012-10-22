//
//  QuantumLayer.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumLayer.h"
#import "QuantumPilot.h"

@implementation QuantumLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	QuantumLayer *layer = [QuantumLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
    if (self){
        QuantumPilot *p = [[QuantumPilot alloc] init];
        p = p;

    }
    return self;
}

@end
