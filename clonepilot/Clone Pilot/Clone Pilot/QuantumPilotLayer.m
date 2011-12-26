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
@synthesize dataLabel1;
@synthesize dataLabel2;
@synthesize wallLabel;

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
        self.dataLabel1 = [CCLabelTTF labelWithString:@"" fontName:@"Courier New" fontSize:23];
        
        // position the label on the center of the screen
        self.dataLabel1.position =  ccp(12,1024-50);
        [self.dataLabel1 setAnchorPoint:ccp(0,0)];
        
        // add the label as a child to this Layer
        [self addChild:self.dataLabel1];
        
        self.dataLabel2 = [CCLabelTTF labelWithString:@"" fontName:@"Courier New" fontSize:23];
        
        // position the label on the center of the screen
        self.dataLabel2.position =  ccp(12,1024-80);
        [self.dataLabel2 setAnchorPoint:ccp(0,0)];
        
        // add the label as a child to this Layer
        [self addChild:self.dataLabel2];
        
        self.wallLabel = [CCLabelTTF labelWithString:@"Wall of Death" fontName:@"Courier New" fontSize:23];
        self.wallLabel.position = ccp(0,0);
        [self addChild:self.wallLabel];

	}
	return self;
}

- (void)update {
    [self.f tick];
    NSString *d1String = [NSString stringWithFormat:@"Wave: %d",[self.f level]];
    self.dataLabel1.string = d1String;
    NSString *d2String = [NSString stringWithFormat:@"Score: %d",[self.f score]];
    self.dataLabel2.string = d2String; 
    self.wallLabel.position = self.f.wall.l;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self.f addTouch:[touch locationInView:[touch view]] last:[touch previousLocationInView:[touch view]] timestamp:touch.timestamp];
    //    [self.f plusTouch:touch];
//    CGPoint tliv = [touch locationInView:[touch view]];
//    CGPoint tl = ccp(tliv.x, 1024-tliv.y);   
//    [self.f addTouch:tl];
}

// Override the "ccTouchesMoved:withEvent:" method to add your own logic
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// This method is passed an NSSet of touches called (of course) "touches"
	// "allObjects" returns an NSArray of all the objects in the set
	NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        NSLog(@"touch timestamp: %f",touch.timestamp);
        [self.f moveTouch:[touch locationInView:[touch view]] last:[touch previousLocationInView:[touch view]] timestamp:touch.timestamp];
        //        [self.f varyTouch:touch];
//        CGPoint tliv = [touch locationInView:[touch view]];
//        CGPoint tl = ccp(tliv.x, 1024-tliv.y);
//        [self.f moveTouch:tl];
    }
    
	
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
//        [self.f finishTouch:touch];
        CGPoint tliv = [touch locationInView:[touch view]];
        CGPoint tl = ccp(tliv.x, 1024-tliv.y);
        [self.f endTouch:tl last:[touch previousLocationInView:[touch view]] timestamp:touch.timestamp];
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc {
    [f release];	
    [dataLabel1 removeFromParentAndCleanup:YES];
    [dataLabel1 release];
    [dataLabel2 removeFromParentAndCleanup:YES];
    [dataLabel2 release];
    
	[super dealloc];
}


@end
