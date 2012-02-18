#import "SingleLaser.h"
#import "SingleLaserBullet.h"

@implementation SingleLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    SingleLaserBullet *b = [[[SingleLaserBullet alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    return [NSArray arrayWithObject:b];
}

- (void)setDrawColor {
    glColor4f(.1, .9, .1, 1.0);
}


@end
