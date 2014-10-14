//
//  QPBFDisplay.m
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "QPBFDisplay.h"
#import "QuantumPilot.h"

@implementation QPBFDisplay

- (id)init {
    self = [super init];
    if (self) {
        [self initializeLocation];
        [self initializeVertexes];
    }
    
    return self;
}


- (void)initializeLocation {
    l = [QuantumPilot resetPosition];
}

- (void)initializeVertexes {
    vertexes[0] = ccp(5000, 5000);
    vertexes[1] = ccp(5000, 5000);
    vertexes[2] = ccp(5000, 5000);
    vertexes[3] = ccp(5000, 5000);
}

- (NSString *)timeText {
    return nil;
}

- (NSString *)accuracyText {
    return nil;
}

- (NSString *)pathingText {
    return nil;
}

- (NSString *)scoreText {
    return nil;
}

- (CGPoint)timePosition {
    float h = 578;
    return ccp(l.x - [self labelDistance], h - (l.y + [self labelDistance]));
}

- (CGPoint)accuracyPosition {
    float h = 578;
    return ccp(l.x + [self labelDistance], h - (l.y + [self labelDistance]));
}

- (CGPoint)pathingPosition {
    float h = 578;
    return ccp(l.x - [self labelDistance], h - (l.y - [self labelDistance]));
}

- (CGPoint)scorePosition {
    float h = 578;
    return ccp(l.x + [self labelDistance], h - (l.y - [self labelDistance]));
}

- (void)drawLabels {
    float distance = [self labelDistance];
    vertexes[0] = ccp(l.x - distance, l.y);
    vertexes[1] = ccp(l.x, l.y + distance);
    vertexes[2] = ccp(l.x + distance, l.y);
    vertexes[3] = ccp(l.x, l.y - distance);
    
    NSDictionary *l1 = @{@"x" : [NSNumber numberWithFloat:[self timePosition].x], @"y" : [NSNumber numberWithFloat:[self timePosition].y], @"text" : [self timeText]};
    NSDictionary *l2 = @{@"x" : [NSNumber numberWithFloat:[self accuracyPosition].x], @"y" : [NSNumber numberWithFloat:[self accuracyPosition].y], @"text" : [self accuracyText]};
    NSDictionary *l3 = @{@"x" : [NSNumber numberWithFloat:[self pathingPosition].x], @"y" : [NSNumber numberWithFloat:[self pathingPosition].y], @"text" : [self pathingText]};
    NSDictionary *l4 = @{@"x" : [NSNumber numberWithFloat:[self scorePosition].x], @"y" : [NSNumber numberWithFloat:[self scorePosition].y], @"text" : [self scoreText]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"L1" object:l1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"L2" object:l2];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"L3" object:l3];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"L4" object:l4];
}

- (void)draw {
    ccDrawColor4F(1, 1, 1, 1.0);
    ccDrawPoly(vertexes, 4, true);
}

- (void)pulse {
    [self drawLabels];
}
- (float)labelDistance {
    return [self baseLabelDistance];
}
- (float)baseLabelDistance {
    return 50;
}
- (void)drawText {
    
}

- (CGPoint)center {
    return l;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
