//
//  BattleWindow.h
//  QuantumPilot
//
//  Created by quantum on 13/10/2014.
//
//

#import <UIKit/UIKit.h>
#import "BattleLabel.h"
#import "ScoreLabel.h"
#import "AccuracyLabel.h"
#import "KillsLabel.h"
#import "CCScheduler.h"
#import "PathsLabel.h"
#import "WeaponsLabel.h"
#import "BoostButton.h"
#import "LaserButton.h"

#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface BattleWindow : UIWindow <MFMessageComposeViewControllerDelegate> {
    float _time;
    bool _sharing;
}

@property (strong, nonatomic) UILabel *l1;
@property (strong, nonatomic) UILabel *l2;
@property (strong, nonatomic) UILabel *l3;
@property (strong, nonatomic) UILabel *l4;

@property (strong, nonatomic) UILabel *debrisLabel;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitle;

@property (strong, nonatomic) UILabel *guide;

@property (strong, nonatomic) WeaponsLabel *weaponLabel;
@property (strong, nonatomic) ScoreLabel *scoreLabel;

@property (strong, nonatomic) UILabel *speedLabel;

@property (strong, nonatomic) AccuracyLabel *accuracyLabel;
@property (strong, nonatomic) PathsLabel *pathsLabel;
@property (strong, nonatomic) KillsLabel *killsLabel;
@property (strong, nonatomic) BattleLabel *leaderboardLabel;

@property (strong, nonatomic) NSTimer *breath;

@property (strong, nonatomic) UIImageView *twitterIcon;
@property (strong, nonatomic) UIImageView *facebookIcon;
//@property (strong, nonatomic) UIImageView *instagramIcon;
@property (strong, nonatomic) UIImageView *messageIcon;

@property (strong, nonatomic) BoostButton *boostbutton;
@property (strong, nonatomic) LaserButton *laserbutton;

- (NSArray *)labels;

@end
