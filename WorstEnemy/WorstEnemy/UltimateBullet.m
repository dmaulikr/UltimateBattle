//
//  UltimateBullet.m
//  WorstEnemy
//
//  Created by Anthony Broussard on 4/22/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "UltimateBullet.h"
#import "CCParticleExamples.h"


@implementation UltimateBullet
@synthesize l, particles;

-(void)createParticles {
	self.particles = [NSMutableArray array];
	
	for (int i = 0; i < 1; i++) {
		id particle;
		particle = [[CCParticleMeteor alloc] initWithTotalParticles:500];
		[particle setPosition:CGPointMake(self.l.x, self.l.y + (i * 10))];
		 [particle setAngle:0.0];
		 [particle setAngleVar:0.0];
		[particle setStartSize:.5];
		 [particle setPosVar:CGPointMake(0,0)];
		 [particle setEndSize:.5];
		 [particle setLife:.05];
		 [particle setLifeVar:.01];
		 [particle setSpeed:0];
		 [particle setSourcePosition:CGPointMake(0,0)];

		 [particle setTexture:nil];
		 [self.particles addObject:particle];
		 [particle release];
		 }
		 
		 }
		 
		 @end
