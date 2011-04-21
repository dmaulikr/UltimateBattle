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
		self.battle = [[WorstEnemyBattlefield alloc] initWithLayer:self];
	}
	return self;
}

@end
