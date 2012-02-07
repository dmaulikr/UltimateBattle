#import "QPWeaponOptionLayer.h"

@implementation QPWeaponOptionLayer
@synthesize weapon;
@synthesize weaponSprite;
@synthesize weaponText;

- (void)generateDisplay {
    self.weaponSprite = [CCSprite spriteWithFile:[self.weapon weaponImagePath]]; 
    
    self.weaponText = [CCLabelTTF labelWithString:NSStringFromClass([self.weapon class]) 
                                         fontName:@"Arial" 
                                         fontSize:10];
    self.weaponText.color = ccc3(255,255,255);
}

- (id)initWithWeapon:(Weapon *)w {
    self = [super init];
    if (self) {
        self.weapon = w;
        [self generateDisplay];
    }
    
    return self;
}

- (void)addWeaponOptionsToLayer:(CCLayer *)layer {
    [layer addChild:self.weaponSprite];
    [layer addChild:self.weaponText];
}

- (void)removeDisplay {
    [self.weaponSprite removeFromParentAndCleanup:YES];
    self.weaponSprite = nil;
    [self.weaponText removeFromParentAndCleanup:YES];
    self.weaponText = nil;
}

- (void)positionDisplayAroundLocation:(CGPoint)l {
    [self.weaponSprite setPosition:ccp(l.x,l.y + 40)];
    [self.weaponText setPosition:ccp(l.x,l.y - 40)];
}

- (void)dealloc {
    [weapon release];
    if ([weaponSprite parent]) {
        [weaponSprite removeFromParentAndCleanup:YES];
    }
    [weaponSprite release];
    if ([weaponText parent]) {
        [weaponText removeFromParentAndCleanup:YES];
    }
    [weaponSprite release];
    [super dealloc];
}

@end
