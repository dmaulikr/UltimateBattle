//
//  BattleWindow.h
//  QuantumPilot
//
//  Created by quantum on 13/10/2014.
//
//

#import <UIKit/UIKit.h>

@interface BattleWindow : UIWindow

@property (strong, nonatomic) UILabel *l1;
@property (strong, nonatomic) UILabel *l2;
@property (strong, nonatomic) UILabel *l3;
@property (strong, nonatomic) UILabel *l4;

@property (strong, nonatomic) UILabel *debrisLabel;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitle;

@property (strong, nonatomic) UILabel *guide;

- (NSArray *)labels;

@end
