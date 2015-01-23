#import "SingleLaserCannon.h"
#import "SingleLaser.h"

@implementation SingleLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction speed:(float)speed {{
    SingleLaser *b = [[[SingleLaser alloc] initWithLocation:location velocity:CGPointMake(0,direction * speed)] autorelease];
    //speed gets base battlefield + .6 * weapon level- (void)powerLaser {
    return [NSArray arrayWithObject:b];
}

+ (void)setDrawColor {
    ccDrawColor4F(1, 1, 1, 1.0);
}

+ (NSString *)weaponName {
    return @"DISMANTLER";
}

+ (UIColor *)weaponColor {
    return [UIColor whiteColor];;
}


@end
