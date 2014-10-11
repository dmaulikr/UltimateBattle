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
        [self initializeLabels];
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

- (void)initializeLabels {
    CGSize size = CGSizeMake(80, 40);
    
    self.timeLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
    self.accuracyLabel = [CCLabelTTF labelWithString:nil  dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
    self.pathingLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
    self.scoreLabel = [CCLabelTTF labelWithString:nil dimensions:size hAlignment:kCCTextAlignmentCenter fontName:@"Courier New" fontSize:13];
    
    [self addChild:self.timeLabel];
    [self addChild:self.accuracyLabel];
    [self addChild:self.pathingLabel];
    [self addChild:self.scoreLabel];
}

- (void)drawLabels {
    float distance = [self labelDistance];
    vertexes[0] = ccp(l.x - distance, l.y);
    vertexes[1] = ccp(l.x, l.y + distance);
    vertexes[2] = ccp(l.x + distance, l.y);
    vertexes[3] = ccp(l.x, l.y - distance);
    
    ccDrawColor4F(1, 1, 1, 1.0);
    
    ccDrawPoly(vertexes, 4, true);
    
    float halfSegment = distance;
    self.timeLabel.position     = ccp(l.x - halfSegment, l.y + halfSegment);
    self.accuracyLabel.position = ccp(l.x + halfSegment, l.y + halfSegment);
    self.pathingLabel.position  = ccp(l.x - halfSegment, l.y - halfSegment);
    self.scoreLabel.position    = ccp(l.x + halfSegment, l.y - halfSegment);
}

- (void)pulse {
    
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
    for (CCLabelTTF *f in @[self.timeLabel, self.accuracyLabel, self.pathingLabel, self.scoreLabel]) {
        [f removeFromParentAndCleanup:true];
        f = nil;
    }
    self.delegate = nil;
    [super dealloc];
}

@end
