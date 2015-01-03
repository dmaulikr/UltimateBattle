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

@property (nonatomic, readonly) int fontSize;

- (id)initWithFrame:(CGRect)frame size:(int)fontSize;

- (void)resetAnimation;

- (void)pulse;

@end
