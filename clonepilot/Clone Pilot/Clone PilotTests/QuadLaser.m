#import "QuadLaser.h"
#import "Bullet.h"
#import "VRGeometry.h"

@implementation QuadLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    CGPoint vel1 = GetAngle(location, CGPointMake(location.x - 1,location.y + direction * 4));
    vel1 = MultipliedPoint(vel1, self.speed);
    Bullet *b = [[[Bullet alloc] initWithLocation:location velocity:vel1] autorelease];
    
    CGPoint vel2 = GetAngle(location, CGPointMake(location.x - 3,location.y + direction * 4));
    vel2 = MultipliedPoint(vel2, self.speed);
    Bullet *b2 = [[[Bullet alloc] initWithLocation:location velocity:vel2] autorelease];
    
    CGPoint vel3 = GetAngle(location, CGPointMake(location.x + 1,location.y + direction * 4));
    vel3 = MultipliedPoint(vel3, self.speed);
    Bullet *b3 = [[[Bullet alloc] initWithLocation:location velocity:vel3] autorelease];
    
    CGPoint vel4 = GetAngle(location, CGPointMake(location.x + 3,location.y + direction * 4));
    vel4 = MultipliedPoint(vel4, self.speed);
    Bullet *b4 = [[[Bullet alloc] initWithLocation:location velocity:vel4] autorelease];
    
    return [NSArray arrayWithObjects:b, b2, b3, b4, nil];
}

- (void)setDrawColor {
    glColor4f(.05, .05, .9, 1.0);
}


@end