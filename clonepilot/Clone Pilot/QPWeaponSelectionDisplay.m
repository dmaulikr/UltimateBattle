#import "QPWeaponSelectionDisplay.h"

@implementation QPWeaponSelectionDisplay
@synthesize basicWeaponLabel = _basicWeaponLabel;

- (void)setupDisplayForWeapon:(Weapon *)weapon {
    self.basicWeaponLabel = [CCLabelTTF labelWithString:[weapon description]
                                               fontName:@"Courier New"
                                               fontSize:23];
    self.basicWeaponLabel.position = ccp(384, 300);
    [self addChild:self.basicWeaponLabel];
}

- (id)initWithBasicWeapon:(Weapon *)weapon layer:(CCLayer *)layer {
    self = [super init];
    if (self) {
        [self setupDisplayForWeapon:weapon];
        [layer addChild:self];
    }
    return self;
}

- (void)dealloc {
    [self.basicWeaponLabel removeFromParentAndCleanup:YES];
    self.basicWeaponLabel = nil;
    [super dealloc];
}

@end
