//
//  QuantumLayer.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumLayer.h"

@implementation QuantumLayer
@synthesize f = _f;
@synthesize breath = _breath;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	QuantumLayer *layer = [QuantumLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
    if (self){
        self.f = [QPBattlefield f];
        self.f.layer = self;
        [self addChild:self.f];
        [self schedule:@selector(breathe:)];
        self.isTouchEnabled = YES;
        glDisable( GL_BLEND );
        glColorMask(true, true, true, false);
    }
    return self;
}

- (void)breathe:(ccTime)deltaTime {
    _time+= deltaTime;
    if (_time >= 0.016) {
        _time-= 0.016;
        [self.f pulse];
    }
}


//- (void)breathe {
//    [self.f pulse];
//    
//}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint l = [touch locationInView:[touch view]];
        float height = [[UIScreen mainScreen] bounds].size.height;
        [self.f addTouch:ccp(l.x, height-l.y)];
    } else if (touches.count == 2) {
        [self.f addDoubleTouch];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSArray *touchArray = [touches allObjects];
    
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    for (UITouch *touch in touchArray) {
        CGPoint l = [touch locationInView:[touch view]];
        [self.f moveTouch:ccp(l.x, height-l.y)];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArray = [touches allObjects];
    
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    for (UITouch *touch in touchArray) {
        CGPoint l = [touch locationInView:[touch view]];
            [self.f endTouch:ccp(l.x, height-l.y)];
    }
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    CGPoint l = [t locationInView:[t view]];
    float height = [[UIScreen mainScreen] bounds].size.height;
    [self.f endTouch:ccp(l.x, height-l.y)];
}

@end
