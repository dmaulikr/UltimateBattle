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
	self.particles = [[CCParticleMeteor alloc] initWithTotalParticles:250];
	[self.particles setPosition:self.l];
    [self.particles setAngle:0.0];
    [self.particles setAngleVar:0.0];
    [self.particles setStartSize:1.5];
    [self.particles setPosVar:CGPointMake(0,0)];
    [self.particles setEndSize:0.5];
    [self.particles setLife:.05];
    [self.particles setLifeVar:.05];
    [self.particles setSpeed:0];
    [self.particles setSourcePosition:CGPointMake(0,0)];
    [self.particles setTexture:nil];

}

@end
