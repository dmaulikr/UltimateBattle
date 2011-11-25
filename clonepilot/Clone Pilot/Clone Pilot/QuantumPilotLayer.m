//
//  QuantumPilotLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 11/25/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "QuantumPilotLayer.h"

@implementation QuantumPilotLayer
@synthesize f;

+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	QuantumPilotLayer *layer = [QuantumPilotLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}

-(id) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {       
        self.f = [[[ClonePilotBattlefield alloc] initWithLayer:self] autorelease];

        timer = [[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(update) userInfo:nil repeats:YES] retain];

	}
	return self;
}

- (void)update {
    [self.f tick];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
    [f release];	
	[super dealloc];
}


@end
