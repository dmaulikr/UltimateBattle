#import "Bullet.h"

@interface QuadLaser : Bullet {
    CGPoint lines[2];
    int xDirection;
    int yDirection;
}

@property (nonatomic) NSInteger xDirection;

- (float)xDrawRate;
- (float)yDrawRate;

@end
