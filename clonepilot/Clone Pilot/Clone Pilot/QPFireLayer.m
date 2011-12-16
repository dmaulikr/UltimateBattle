//
//  QPFireLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/15/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "QPFireLayer.h"

@implementation QPFireLayer
@synthesize delegate;

+(CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	QPFireLayer *layer = [QPFireLayer node];
	
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

- (void)addTouch:(CGPoint)l {
    if (CGRectContainsPoint(self.boundingBoxInPixels, l)) {
        [self.delegate fireLayerTapped:self];
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    UITouch *touch = [touches anyObject];
    CGPoint tliv = [touch locationInView:[touch view]];
    [self addTouch:tliv];
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
