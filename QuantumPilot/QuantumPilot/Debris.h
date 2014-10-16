//
//  Debris.h
//  QuantumPilot
//
//  Created by quantum on 15/07/2014.
//
//

#import "cocos2d.h"

@interface Debris : CCNode {
    CGPoint _points[10];
    float _speed;
    int _level;
    float radius;
}

@property (nonatomic) CGPoint l;

- (id)initWithL:(CGPoint)l;

- (void)pulse;

- (void)setLevel:(int)l;

- (int)level;

- (bool)dissipated;

- (void)establishColor;
- (void)drawCircle;

- (bool)isDebris;

@end
