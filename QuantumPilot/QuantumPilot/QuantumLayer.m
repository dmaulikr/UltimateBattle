//
//  QuantumLayer.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumLayer.h"
#import "QuantumPilot.h"

@implementation QuantumLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	QuantumLayer *layer = [QuantumLayer node];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
    if (self){
        NSLog(@"hi");
        struct array a = [QuantumPilot returnArray2];
        NSLog(@"%d",a.array[2][9]);
        QuantumPilot *p = [[QuantumPilot alloc] init];
        for (int i = 0; i < 4000; i++) {
            [p setWaypoint:ccp(arc4random() % 800 , arc4random() % 800) index:i];
        }
        struct course nav = [p navigationCourse];
        for (int i = 0; i < 4000; i++) {
            NSLog(@"i: %d  ::::     (%f,%f)", i, nav.waypoints[i].x, nav.waypoints[i].y);
        }
    }
    return self;
}

@end
