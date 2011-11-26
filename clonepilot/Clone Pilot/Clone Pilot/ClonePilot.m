//
//  ClonePilot.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePilot.h"
#import "VRGeometry.h"

@implementation ClonePilot
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize living;
@synthesize weapon;
@synthesize moveIndex;
@synthesize bulletDelegate;
@synthesize sprite;

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 300);
}

+ (NSInteger)identifier {
    return 1;
}

- (Turn *)currentTurn {
    return [self.moves objectAtIndex:self.moveIndex];
}

- (Bullet *)newBullet {
    Bullet *b = [[[Bullet alloc] initWithLocation:self.l velocity:CGPointMake(0,3)] autorelease];
    b.identifier = [ClonePilot identifier];
    return b;
}

- (void)tick {
    if ([self.moves count] > 0) {
        Turn *turn = [self.moves objectAtIndex:self.moveIndex];
        self.vel = turn.vel;
        
        self.l = CombinedPoint(self.l, self.vel);

        self.moveIndex++;
        
        if (turn.firing) {
            NSArray *bullets = [self.weapon newBulletsForLocation:self.l direction:1];
            for (Bullet *b in bullets) {
                b.identifier = [ClonePilot identifier];
            }
            [self.bulletDelegate addBullets:bullets];
        }
        
        if (self.moveIndex >= [self.moves count]) {
            self.moveIndex = 0;
            self.l = [ClonePilot defaultLocation];
        }
    }
    
    if (self.sprite) {
        self.sprite.position = self.l;
    }
}

- (void)reset {
    self.l = [ClonePilot defaultLocation];
    self.moveIndex = 0;
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.l = [ClonePilot defaultLocation];
        self.moves = [NSMutableArray array];
        self.living = YES;
        self.radius = 15;
    }
    
    return self;
}

- (id)init {
    return [self commonInit];
}

- (void)resetSpriteWithLayer:(CCLayer *)layer {
    self.sprite = [[CCSprite spriteWithFile:@"sprite-7-1.png"] retain];
    [layer addChild:self.sprite];
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [self commonInit];
    [self resetSpriteWithLayer:layer];
    
    return self;
}

- (void)dealloc {
    [moves release];
    [weapon release];
    self.bulletDelegate = nil;
    [sprite release];
    [super dealloc];
}

@end
