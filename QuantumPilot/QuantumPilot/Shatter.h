//
//  Shatter.h
//  QuantumPilot
//
//  Created by quantum on 18/10/2014.
//
//

#import "cocos2d.h"

@interface Shatter : CCNode {
    CGPoint c1[2];
    CGPoint c2[2];
    CGPoint c3[2];
    CGPoint c4[2];
    float shipTopHeight;
    float shipSideWidth;
    float shipBottomHeight;
    int iteration;
}

@property (nonatomic) CGPoint l;
@property (nonatomic) int yDirection;
@property (copy, nonatomic) NSString *weapon;

- (void)pulse;

- (id)initWithL:(CGPoint)l weapon:(NSString *)w;

@end
