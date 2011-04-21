//
//  WorstEnemyBattleMindLayer.m
//  WorstEnemy
//
//  Created by X3N0 on 4/20/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "WorstEnemyBattleMindLayer.h"


@implementation WorstEnemyBattleMindLayer
@synthesize battle;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WorstEnemyBattleMindLayer *layer = [WorstEnemyBattleMindLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init {
	self = [super init];
	if (self) {
        self.isTouchEnabled = true;		
		self.battle = [[WorstEnemyBattlefield alloc] initWithLayer:self];
		[self.battle startGame];
	}
	return self;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint touchPoint = [touch locationInView:[touch view]];
	[self.battle touchLocation:CGPointMake(touchPoint.x, 320-touchPoint.y)];
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self ccTouchesBegan:touches withEvent:event];
}


@end
