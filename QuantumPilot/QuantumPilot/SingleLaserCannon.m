#import "SingleLaserCannon.h"
#import "SingleLaser.h"

@implementation SingleLaserCannon

- (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    SingleLaser *b = [[[SingleLaser alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    return [NSArray arrayWithObject:b];
}

- (void)setDrawColor {
    ccDrawColor4F(.1, .9, .1, 1.0);
}


@end
