#import "BulletWall.h"
#import "VRGeometry.h"

@implementation BulletWall
@synthesize l, vel, t, radius, speed;

- (CGPoint)defaultLocation {
    return CGPointMake(384, 1024);
}

- (float)defaultSpeed {
    return .5;
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [super init];
    if (self){
        [layer addChild:self];
        self.l = [self defaultLocation];
        self.speed = [self defaultSpeed];
        self.vel = CGPointMake(0, -self.speed);
    }
    return self;
}

- (void)draw {
    glColor4f(1, 0, 0, 1.0);        
    ccDrawLine(ccp(0,self.l.y),ccp(768,self.l.y));
}

- (void)reset {
    self.l = [self defaultLocation];
}

- (void)tick {
    self.l = CombinedPoint(self.l, self.vel);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

@end
