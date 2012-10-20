#import "ClonePlayer.h"
#import "Weapon.h"
#import "BulletDelegateProtocol.h"

@interface QuantumPilot : CCNode

@property (nonatomic, assign) BOOL firing;
@property (nonatomic) CGPoint l;
@property (nonatomic) CGPoint vel;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic) float speed;
@property (nonatomic) float radius;

@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;

@end
