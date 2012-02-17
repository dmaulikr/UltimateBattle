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

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	QuantumPilotLayer *layer = [QuantumPilotLayer node];
	[scene addChild:layer];
	return scene;
}

-(id) init {
	if( (self=[super init])) {       
        self.f = [[[ClonePilotBattlefield alloc] initWithLayer:self] autorelease];
        [self.f startup];
        timer = [[NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(update) userInfo:nil repeats:YES] retain];
        [self setIsTouchEnabled:YES];
        self.dataLabel1 = [CCLabelTTF labelWithString:@"" fontName:@"Courier New" fontSize:23];
        self.dataLabel1.position =  ccp(12,1024-30);
        [self.dataLabel1 setAnchorPoint:ccp(0,0)];        
        [self addChild:self.dataLabel1];
        self.dataLabel2 = [CCLabelTTF labelWithString:@"" fontName:@"Courier New" fontSize:23];
        self.dataLabel2.position =  ccp(12,1024-60);
        [self.dataLabel2 setAnchorPoint:ccp(0,0)];        
        [self addChild:self.dataLabel2];
	}
	return self;
}

- (void)update {
    [self.f tick];
    NSString *d1String = [NSString stringWithFormat:@"Wave: %d",[self.f level]];
    self.dataLabel1.string = d1String;
    NSString *d2String = [NSString stringWithFormat:@"Score: %d",[self.f score]];
    self.dataLabel2.string = d2String; 
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self.f addTouch:[touch locationInView:[touch view]]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        [self.f moveTouch:[touch locationInView:[touch view]]];
    }    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        [self.f endTouch:[touch locationInView:[touch view]]];
    }
}

- (void) dealloc {
    [f release];	
    [dataLabel1 removeFromParentAndCleanup:YES];
    [dataLabel1 release];
    [dataLabel2 removeFromParentAndCleanup:YES];
    [dataLabel2 release];
	[super dealloc];
}

@end
