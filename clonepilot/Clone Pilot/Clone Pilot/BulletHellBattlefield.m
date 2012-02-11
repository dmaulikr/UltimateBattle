#import "BulletHellBattlefield.h"
#import "QPBattlefieldModifier.h"
#import "QPBulletIdentifierModifier.h"

@implementation BulletHellBattlefield

@synthesize bullets;
@synthesize level;
@synthesize battlefieldModifiers;
@synthesize battlefieldModifierController;
//@synthesize potentialBattlefieldModifiers;

- (void)setupBattlefieldModifiers { 
    QPBulletIdentifierModifier *m = [[[QPBulletIdentifierModifier alloc] init] autorelease];
    [self addBattlefieldModifier:m];
}

- (void)setupPotentialBattlefieldModifiers {
    
}

- (void)createBattlefieldModifierController {
    self.battlefieldModifierController = [[[BulletHellBattlefieldModifierController alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        self.bullets = [NSMutableArray array];
        self.level = 0;
        self.battlefieldModifiers = [NSMutableArray array];
        [self setupBattlefieldModifiers];
        [self createBattlefieldModifierController];
//        self.potentialBattlefieldModifiers = [NSMutableArray array];        
//        [self setupPotentialBattlefieldModifiers];
    }
    
    return self;
}

- (void)bulletLoop {
    NSMutableArray *removableBullets = [NSMutableArray array];

    for (Bullet *b in self.bullets) {
        if (b.finished) {
            [removableBullets addObject:b];
        }
    }

    for (Bullet *b in removableBullets) {
        if (b.sprite) {
            [b.sprite removeFromParentAndCleanup:YES];
        }
    }
    
    [self.bullets removeObjectsInArray:removableBullets];
    
    
    for (Bullet *b in self.bullets) {
        [b tick];
    }
}

- (void)addBullets:(NSArray *)bullets_ {
    for (Bullet *b in bullets_) {
        [self.bullets addObject:b];
    }
}

- (void)addBullets:(NSArray *)bullets_ ship:(QPShip *)ship {
    for (QPBattlefieldModifier *m in self.battlefieldModifiers) {
        [m addBullets:bullets_ ship:ship];
    }
    [self addBullets:bullets_];
}

- (void)fired {
    
}

- (void)modifierLoop {
    for (BulletHellBattlefieldModifier *m in self.battlefieldModifiers) {
        [m modifyBattlefield:self];
    }
}

- (void)tick {
    [self modifierLoop];
    [self bulletLoop];

}

- (void)addBullet:(Bullet *)b {
    [self.bullets addObject:b];
}

- (void)addBattlefieldModifier:(BulletHellBattlefieldModifier *)m {
    [self.battlefieldModifiers addObject:m];
}

- (void)dealloc {
    [bullets release];
    [battlefieldModifiers release];
    [battlefieldModifierController release];
    //    [potentialBattlefieldModifiers release];
    [super dealloc];
}

@end
