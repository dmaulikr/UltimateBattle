#import "SingleLaser.h"
#import "Bullet.h"

@implementation SingleLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    Bullet *b = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    return [NSArray arrayWithObject:b];
}

- (void)setDrawColor {
    glColor4f(.1, .9, .1, 1.0);
}


@end
