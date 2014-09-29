#import "Bullet.h"

@interface QuadLaser : Bullet {
    CGPoint lines[2];
}

@property (nonatomic) NSInteger xDirection;

- (float)xDrawRate;
- (float)yDrawRate;

@end
