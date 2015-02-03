//
//  BattleLabel.h
//  QuantumPilot
//
//  Created by quantum on 03/01/2015.
//
//

#import <UIKit/UIKit.h>

@interface BattleLabel : UILabel {
    int timer;
    int bonusFont;
    int defaultSize;
}

- (void)processMaxFont;

- (id)initWithFrame:(CGRect)frame size:(int)fontSize;

- (void)resetAnimation:(NSNotification *)n;

- (void)pulse;

- (void)setupNotifications;

- (int)maximumBonusFont;

- (int)bonusFontIncrease;

- (void)cancel;

- (NSString *)nameOfFont;

@end
