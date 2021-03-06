//
//  RecycleDisplay.h
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "cocos2d.h"
#import "ScoreDisplay.h"

@interface RecycleDisplay : ScoreDisplay {
    NSString *_weapon;
    int _debris;
    
    int _weaponCost;
    
    bool warning;
    bool slow;
}

@property (strong, nonatomic) CCLabelTTF *debrisLabel;

- (void)showWeapon:(NSString *)w;
- (void)showWeapon:(NSString *)w cost:(int)cost;
- (void)showWarningActivated:(bool)w;
- (void)showSlow:(bool)s;

- (void)reloadDebrisLabel:(int)d;

@end
