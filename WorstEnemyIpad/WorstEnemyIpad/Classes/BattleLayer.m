//
//  HelloWorldLayer.m
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 3/21/11.
//  Copyright Pursuit 2011. All rights reserved.
//


// Import the interfaces
#import "BattleLayer.h"

// HelloWorldLayer implementation
@implementation BattleLayer

@synthesize ship;
@synthesize killerBar;
@synthesize bullets;
@synthesize enemyBullets;
@synthesize enemies;
@synthesize kill_count;
@synthesize newLevelDelay;
@synthesize pastLives;
@synthesize isMovingToNextLevel;

#define NEW_LEVEL_DELAY 100
#define ENEMY_START ccp(100, 150)
#define PLAYER_START ccp(400, 150)

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BattleLayer *layer = [BattleLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        self.ship = [[[Ship alloc] initWithLocation:PLAYER_START] autorelease];
        [self.ship addToLayer:self];
        self.killerBar = [[[KillerBar alloc] init] autorelease];
        [self.killerBar addToLayer:self];
        
        self.bullets = [NSMutableArray array];
        self.enemyBullets = [NSMutableArray array];
        self.enemies = [NSMutableArray array];
        self.pastLives = [NSMutableArray array];
        self.newLevelDelay = NEW_LEVEL_DELAY;
        
        self.kill_count = 0;
        
        self.isTouchEnabled = true;
        self.isMovingToNextLevel = false;
        
        [self createFirstEnemy];
        
        [self schedule:@selector(update:)];
	}
	return self;
}
                                                                  
-(void) createFirstEnemy {
    Move *standStill = [[[Move alloc] initWithFromPoint:ENEMY_START withStartTime:0] autorelease];
    [standStill endMoveWithToPoint:ENEMY_START withEndTime:10];
    
    NSMutableArray *standingStill = [NSMutableArray arrayWithObject:standStill];
    [self.pastLives addObject:standingStill];
}

-(void) createExplosion:(CGPoint) point {
    id explosion = [[CCParticleExplosion alloc] initWithTotalParticles:50];
    [explosion setPosition:point];
    [explosion setSpeed:100];
    [explosion setStartSize:5];
    [explosion setEndSize:1];
    [explosion setLife:0.2];
    [self addChild:explosion];  
    [explosion release];
}

-(void) addEnemy:(ccTime) dt {
    float x = (arc4random() % 5);
    float y = (arc4random() % 10) - 5.0;
    
    EnemyShip *enemy = [[EnemyShip alloc] initWithStart:ccp(100,150) withVelocity:ccp(x,y)];
    [self.enemies addObject:enemy];
    [enemy addToLayer:self];
    [enemy release];
}

-(void) killPlayer {
    //NSLog(@"Kill player");
    [self createExplosion:self.ship.sprite.position];
}

-(void) update:(ccTime) dt {
    if (self.isMovingToNextLevel) {
        return; 
    }
    
    [self.ship addTime:dt];
    
    if (self.newLevelDelay > 0) {
        self.newLevelDelay--;
        return;
    }
    
	
    if (CGRectIntersectsRect([self.killerBar getRect], [self.ship getRect])) {
        [self killPlayer];
    }
    
    NSArray *bullets_to_add = [self.ship fire];
    if (bullets_to_add) {
        for(id<BulletProtocol> b in bullets_to_add) {
            [self.bullets addObject:b];
            [b addToLayer:self];
        }
    }
    
    NSMutableArray *enemyBulletsToAdd = [NSMutableArray array];
    for (EnemyShip *e in self.enemies) {
        [enemyBulletsToAdd addObjectsFromArray:[e fire]];
    }; 
    
    if (enemyBulletsToAdd) {
        for(id<BulletProtocol> b in enemyBulletsToAdd) {
            [self.enemyBullets addObject:b];
            [b addToLayer:self];
        }
    }    

    
    NSMutableArray *bullets_to_remove = [NSMutableArray array];
    for (id<BulletProtocol> b in self.bullets) {
        if (b.sprite.position.x < 0){
            [bullets_to_remove addObject:b];
        }
    }
    for (id<BulletProtocol> b in self.enemyBullets) {
        if (b.sprite.position.x >400){
            [bullets_to_remove addObject:b];
        }
    }
    
    for (id<BulletProtocol> b in bullets_to_remove) {
        [b removeFromLayer:self];
        [self.bullets removeObject:b];
    }; 

    NSMutableArray *enemies_to_destroy = [NSMutableArray array];
    for (id<BulletProtocol> b in self.bullets) {
        for(EnemyShip *e in self.enemies) {
            if (!e.isDead) {
                if (CGRectIntersectsRect([b getRect], [e getRect])) {
                    [enemies_to_destroy addObject:e];
					[b.sprite setPosition:ccp(-1000,-1000)];
                }
            }
        }
    }
    
    for (EnemyShip *e in enemies_to_destroy) {
        self.kill_count++;
        [e removeFromLayer:self];
        [self.enemies removeObject:e];
        [self createExplosion:e.sprite.position];
    }
    
    if ([self enemiesAreAllDead]) {
        [self newLevel];
    }
}

-(void) newLevel {
    NSLog(@"NEW LEVEL!");
    self.isMovingToNextLevel = true;
    
    [self.killerBar reset];
    
    NSLog(@"?");
    [self.ship endCurrentMove];
        NSLog(@"??");
    [self.pastLives addObject:self.ship.moves];
        NSLog(@"???");
    [self.ship reset];
        NSLog(@"????");
    
    NSLog(@"past lives count %d", self.pastLives.count);
    
    for(NSMutableArray *moves in self.pastLives) {
        NSLog(@"add enemy");
        EnemyShip *enemy = [[EnemyShip alloc] initWithMoves:moves atStartPoint:ccp(100,150)];
        [enemy addToLayer:self];
        [self.enemies addObject:enemy];
        [enemy release]; 
    }

    self.kill_count = 0;

    for (WBullet *b in self.bullets) {
        [b removeFromLayer:self];
    }
    [self.bullets removeAllObjects];
    
    self.newLevelDelay = NEW_LEVEL_DELAY;
    self.isMovingToNextLevel = false;
}

-(BOOL) enemiesAreAllDead {
    //NSLog(@"enemy count %i : kill count %i", self.enemies.count, self.kill_count);
    return self.enemies.count == 0;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint touchPoint = [touch locationInView:[touch view]];
    CGPoint pointToMoveTo = [[CCDirector sharedDirector] convertToGL:touchPoint];
    [self.ship moveTo:pointToMoveTo];
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self ccTouchesBegan:touches withEvent:event];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    self.ship = nil;
    self.bullets = nil;
    self.pastLives = nil;
    self.enemies = nil;
    self.enemyBullets = nil;
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
