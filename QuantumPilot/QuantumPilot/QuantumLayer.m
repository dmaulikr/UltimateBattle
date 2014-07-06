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
        
        self.breath = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(breathe) userInfo:nil repeats:YES];
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)breathe {
    [self.f pulse];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint l = [touch locationInView:[touch view]];
        [self.f addTouch:ccp(l.x, 578-l.y)];
    } else if (touches.count == 2) {
        [self.f addDoubleTouch];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        CGPoint l = [touch locationInView:[touch view]];

        [self.f moveTouch:ccp(l.x, 578-l.y)];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchArray = [touches allObjects];
    
    for (UITouch *touch in touchArray) {
        CGPoint l = [touch locationInView:[touch view]];
        if (l.x > 320) {
            NSLog(@"Hello!");
        }
        [self.f endTouch:ccp(l.x, 578-l.y)];
    }
}

@end
