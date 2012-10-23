#import "WeaponsTestLayer.h"
#import "SingleLaser.h"
#import "TriLaser.h"
#import "QuadLaser.h"


@implementation WeaponsTestLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	WeaponsTestLayer *layer = [WeaponsTestLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
    if (self) {
        SingleLaser *l = [[SingleLaser alloc] init];
        l.l = ccp(400,400);
        l.vel = ccp(0,5);
        [self.f addChild:l];
        //      [self.f.bullets addObject:l];
        
        TriLaser *tl = [[TriLaser alloc] init];
        tl.yDirection = -1;
        tl.l = ccp(500, 400);
        tl.vel = ccp(0,-5);
        [self.f addChild:tl];
        //        [self.f.bullets addObject:tl];
        
        TriLaser *tl2 = [[TriLaser alloc] init];
        tl2.yDirection = 1;
        tl2.l = ccp(600, 400);
        tl2.vel = ccp(0,5);
        [self.f addChild:tl2];
        //    [self.f.bullets addObject:tl2];
        
        QuadLaser *ql = [[QuadLaser alloc] init];
        ql.l = ccp(200, 400);
        ql.xDirection = -1;
        ql.vel = ccp(0,5);
        [self.f addChild:ql];
        //        [self.f.bullets addObject:ql];
        
        QuadLaser *ql2 = [[QuadLaser alloc] init];
        ql2.l = ccp(300, 400);
        ql2.xDirection = 1;
        ql2.vel = ccp(0,5);
        [self.f addChild:ql2];
        //        [self.f.bullets addObject:ql2];
    }
    return self;
}

@end
