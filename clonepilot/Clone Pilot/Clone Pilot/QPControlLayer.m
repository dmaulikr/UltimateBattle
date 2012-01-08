//
//  QPFireLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/15/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "QPControlLayer.h"

@implementation QPControlLayer
@synthesize delegate;

+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	QPControlLayer *layer = [QPControlLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}

- (id)init {
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
    }
    return self;
}

- (BOOL)pointWithinFiringLayer:(CGPoint)l {
    return CGRectContainsPoint(self.boundingBoxInPixels, CGPointMake(l.x, 1024-l.y));
}

- (void)layerTapped {
    //subclasses override
}

- (void)addTouch:(CGPoint)l {
    if ([self pointWithinFiringLayer:l]) {
        [self layerTapped];
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    UITouch *touch = [touches anyObject];
    CGPoint tliv = [touch locationInView:[touch view]];
    if ([self pointWithinFiringLayer:tliv]) {
        [self layerTapped];
    }

}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
