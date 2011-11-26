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
        [self.f startup];
        timer = [[NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(update) userInfo:nil repeats:YES] retain];
        [self setIsTouchEnabled:YES];
	}
	return self;
}

- (void)update {
    [self.f tick];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint tliv = [touch locationInView:[touch view]];
    CGPoint tl = ccp(tliv.x, 1024-tliv.y);
    
    [self.f addTouch:tl];
}

// Override the "ccTouchesMoved:withEvent:" method to add your own logic
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// This method is passed an NSSet of touches called (of course) "touches"
	// "allObjects" returns an NSArray of all the objects in the set
	NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        CGPoint tliv = [touch locationInView:[touch view]];
        CGPoint tl = ccp(tliv.x, 1024-tliv.y);
        [self.f moveTouch:tl];
    }
    
	
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        CGPoint tliv = [touch locationInView:[touch view]];
        CGPoint tl = ccp(tliv.x, 1024-tliv.y);
        [self.f endTouch:tl];
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc {
    [f release];	
	[super dealloc];
}


@end
