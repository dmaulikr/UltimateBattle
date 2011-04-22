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
	self.particles = [[CCParticleFire alloc] initWithTotalParticles:50];
	[self.particles setPosition:self.l];
    [self.particles setAngle:0.0];
    [self.particles setAngleVar:0.0];
    [self.particles setStartSize:2.0];
    [self.particles setPosVar:CGPointMake(0,4)];
    [self.particles setEndSize:0.01];
    [self.particles setLife:0.2];
    [self.particles setLifeVar:0.1];
    [self.particles setSpeed: 200];
    [self.particles setSourcePosition:CGPointMake(0,0)];
    [self.particles setTexture:nil];	
}

@end
