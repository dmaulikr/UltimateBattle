//
//  UpgradeButton.h
//  QuantumPilot
//
//  Created by quantum on 22/01/2015.
//
//

#import <UIKit/UIKit.h>

@protocol UpgradeButtonTapped;

@interface UpgradeButton : UIView

@property (strong, nonatomic) UILabel *label;

- (void)upgrade;

- (NSString *)updateNotificationName;

- (void)styleLabel;

@end
