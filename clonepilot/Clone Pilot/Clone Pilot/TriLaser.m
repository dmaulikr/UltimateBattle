#import "TriLaser.h"
#import "TriLaserBullet.h"

@implementation TriLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    TriLaserBullet *b = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    TriLaserBullet *b2 = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(-1,direction * self.speed)] autorelease];
    TriLaserBullet *b3 = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(1,direction * self.speed)] autorelease];        
    return [NSArray arrayWithObjects:b, b2, b3, nil];
}

- (void)setDrawColor {
    glColor4f(.8, .2, .2, 1.0);
}

@end