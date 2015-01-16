//
//  BattleWindow.m
//  QuantumPilot
//
//  Created by quantum on 13/10/2014.
//
//

#import "BattleWindow.h"
#import "cocos2d.h"
#import "Arsenal.h"
#import "Weapon.h"
#import "CCScheduler.h"
#import "QPBattlefield.h"

static float topCenter = 0.21f;

@implementation BattleWindow

- (NSArray *)labels {
    return @[self.l1, self.l2, self.l3, self.l4, self.debrisLabel, self.titleLabel, self.subTitle, self.guide, self.speedLabel, self.accuracyLabel, self.pathsLabel, self.killsLabel, self.leaderboardLabel];
}

- (void)hideIcons {
    for (UIView *v in [self socialIcons]) {
        v.center = ccp(5000, 5000);
    }
}

- (NSArray *)socialIcons {
    return @[self.twitterIcon, self.facebookIcon, self.messageIcon];
}

- (void)setupSocialIcons {
    self.twitterIcon        = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter.png"]] autorelease];
    self.facebookIcon       = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebook.png"]] autorelease];
//    self.instagramIcon      = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"instagram.png"]] autorelease];
    self.messageIcon        = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message.png"]] autorelease];
    
    [self.twitterIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterTapped)]];
    [self.facebookIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookTapped)]];
//    [self.instagramIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(instagramTapped)]];
    [self.messageIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageTapped)]];
    
    for (UIView *v in [self socialIcons]) {
        v.transform = CGAffineTransformMakeScale(.5, .5);
        [self addSubview:v];
        v.userInteractionEnabled = true;
    }
    [self hideIcons];
}

- (void)setupLabels {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    [self setupSocialIcons];
    
    self.l1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    
    self.debrisLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 100)] autorelease];
    self.subTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 60)] autorelease];
    self.guide = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 106, 60)] autorelease];
    
    float height = size.height - 10;
    
    self.speedLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    self.killsLabel = [[[KillsLabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 90) size:16] autorelease];
    
    self.weaponLabel = [[[WeaponsLabel alloc] initWithFrame:CGRectMake(0, height-27, size.width, 90) size:16] autorelease];
    self.weaponLabel.textColor = [UIColor whiteColor];
    self.weaponLabel.center = ccp(size.width / 2, 10);
    self.weaponLabel.textAlignment = NSTextAlignmentCenter;
    
    self.scoreLabel = [[[ScoreLabel alloc] initWithFrame:CGRectMake(size.width -200, height-27, size.width * 2, 90) size:16] autorelease];
    self.scoreLabel.center = ccp(size.width / 2, 30);
    self.scoreLabel.textColor = [UIColor whiteColor];

    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    self.accuracyLabel  = [[[AccuracyLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 90) size:16] autorelease];
    self.pathsLabel     = [[[PathsLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90) size:16] autorelease];
    
    self.leaderboardLabel = [[[BattleLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 90) size:16] autorelease];
    self.leaderboardLabel.text = @"#1\n ";
    self.leaderboardLabel.center = ccp(5000,5000);
    
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL1:) name:@"L1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL2:) name:@"L2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL3:) name:@"L3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL4:) name:@"L4" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGuide:) name:@"Guide" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDebrisLabel:) name:@"DebrisLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitleLabel:) name:@"TitleLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSubtitleLabel:) name:@"SubtitleLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSpeedLabel:) name:@"SpeedLabel" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLabels) name:@"clearLabels" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeaponLabel:) name:@"WeaponLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScoreLabel:) name:@"ScoreLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAccuracyLabel:) name:@"AccuracyLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePathsLabel:) name:@"PathsLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateKillsLabel:) name:@"KillsLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLeaderboardLabel:) name:@"LeaderboardLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLeaderboardLabel:) name:@"LeaderboardLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSocial:) name:@"ShowSocial" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponLabel" object:[NSNumber numberWithInteger:0]];
}

- (void)styleLabels {
    for (UILabel *l in [self labels]) {
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor whiteColor];
        l.numberOfLines = 0;
        l.lineBreakMode = NSLineBreakByWordWrapping;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:12];
    }
    
    self.guide.textColor = [UIColor greenColor];
    
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    self.subTitle.font = [UIFont systemFontOfSize:16];
    
    self.killsLabel.textColor = [UIColor redColor];
    self.accuracyLabel.textColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    self.pathsLabel.textColor = [UIColor greenColor];
    self.speedLabel.font = [UIFont systemFontOfSize:22];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupLabels];
    [self styleLabels];
    [self setupNotifications];
    self.breath = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(breathe) userInfo:nil repeats:YES];
    return self;
}

- (void)breathe {
    [self.scoreLabel pulse];
    [self.killsLabel pulse];
    [self.pathsLabel pulse];
    [self.accuracyLabel pulse];
    [self.weaponLabel pulse];
}

- (void)updateWeaponLabel:(NSNotification *)n {
    int i = [n.object intValue];
    if (i == -1) {
        self.weaponLabel.text = @"";
        return;
    }
    Class w = [Arsenal weaponIndexedFromArsenal:i];
    
    self.weaponLabel.text = [w weaponName];
    self.weaponLabel.textColor = [w weaponColor];
}

- (void)updateSpeedLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    self.speedLabel.center = ccp(size.width / 2, size.height - 10);
    self.speedLabel.text = n.object;
}

- (void)updateScoreLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int s = [n.object intValue];
    if (s >= 0) {
        self.scoreLabel.text = n.object;
        self.scoreLabel.center = ccp(size.width / 2, 30);
        self.scoreLabel.textColor = [UIColor whiteColor];
    } else {
        self.scoreLabel.center = ccp(size.width / 2, 52);
        self.scoreLabel.font = [UIFont systemFontOfSize:24];
        self.scoreLabel.textColor = [UIColor whiteColor];
        self.scoreLabel.backgroundColor = [UIColor clearColor];
        self.scoreLabel.text = [NSString stringWithFormat:@"%d", -s];
    }
}

- (void)updateLabel:(UILabel *)l withData:(NSDictionary *)d {
    l.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    l.text = d[@"text"];
}

- (void)updateGuide:(NSNotification *)n {
    [self updateLabel:self.guide withData:n.object];
}

- (void)updateTitleLabel:(NSNotification *)n {
    [self updateLabel:self.titleLabel withData:n.object];
}

- (void)updateSubtitleLabel:(NSNotification *)n {
    [self updateLabel:self.subTitle withData:n.object];
}

- (void)updateL1:(NSNotification *)n {
    [self updateLabel:self.l1 withData:n.object];
}

- (void)updateL2:(NSNotification *)n {
    [self updateLabel:self.l2 withData:n.object];
}

- (void)updateL3:(NSNotification *)n {
    [self updateLabel:self.l3 withData:n.object];
}

- (void)updateL4:(NSNotification *)n {
    [self updateLabel:self.l4 withData:n.object];
}

- (void)hideLabels {
    for (UILabel *l in [self labels]) {
        if (l != self.titleLabel && l!= self.subTitle) {
            l.center = ccp(5000,5000);
        }
    }
}

- (void)updateDebrisLabel:(NSNotification *)n {
    NSDictionary *d = n.object;
    float height = [[UIScreen mainScreen] bounds].size.height;
    self.debrisLabel.center = ccp([d[@"x"] intValue], height - [d[@"y"] intValue]); //could post 1, use index
    self.debrisLabel.text = d[@"text"];
}

- (void)updateAccuracyLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int acc = [[n.object objectForKey:@"accuracy"] intValue];
    
    if ([[n.object objectForKey:@"corner"] boolValue]) {
        self.accuracyLabel.center = ccp(0.1f * size.width, 10);
        self.accuracyLabel.text = [NSString stringWithFormat:@"%d%%", abs(acc)];
        if ([n.object objectForKey:@"cancel"]) {
            [self.accuracyLabel cancel];
        }
    } else {
        self.accuracyLabel.text = [NSString stringWithFormat:@"%d\n%%", abs(acc)];
        self.accuracyLabel.center = ccp(0.40f * size.width, topCenter * size.height);
        [self.accuracyLabel cancel];
    }
}

- (void)updatePathsLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int paths = [n.object intValue];
    
    if (paths >= 0) {
        self.pathsLabel.center = ccp(0.9f * size.width, 10);
        self.pathsLabel.text = [NSString stringWithFormat:@"%dζ", abs(paths)];
    } else {
        self.pathsLabel.center = ccp(0.6f * size.width, topCenter *  size.height);
        self.pathsLabel.text = [NSString stringWithFormat:@"%d\nζ", abs(paths)];
        [self.pathsLabel cancel];
    }
}

- (void)updateKillsLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int kills = [n.object[@"kills"] intValue];
    if (n.object[@"x"]) {
        self.killsLabel.center = ccp([n.object[@"x"] floatValue], ([n.object[@"y"] floatValue]));
        [self.killsLabel displayText];
    } else {
        self.killsLabel.center = ccp(0.2f * size.width, topCenter * size.height);
        self.killsLabel.alpha = 1;
        self.killsLabel.text = [NSString stringWithFormat:@"%d\n¤", abs(kills)];
        [self.killsLabel cancel];
    }
}

- (void)updateLeaderboardLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    self.leaderboardLabel.center = ccp(0.8f * size.width, topCenter * size.height);
    [self.leaderboardLabel cancel];
}

- (void)showSocial:(NSNotification *)n {
    [self.scoreLabel cancel];
    if (n.object) {
        for (UILabel *l in @[self.killsLabel, self.accuracyLabel, self.pathsLabel, self.leaderboardLabel]) {
            l.center = ccp(5000,5000);
        }
        if (!_sharing) {
            CGSize size = [[UIScreen mainScreen] bounds].size;
            self.twitterIcon.center     = ccp(0.75f * size.width, topCenter * size.height);
            self.facebookIcon.center    = ccp(0.25f * size.width, topCenter * size.height);
            self.messageIcon.center     = ccp(0.5f * size.width, topCenter * size.height);
//            self.instagramIcon.center   = ccp(0.6f * size.width, topCenter * size.height);

            for (UIView *v in [self socialIcons]) {
                [self bringSubviewToFront:v];
            }
        }
    } else {
        [self hideIcons];
    }
}

- (NSString *)shareText {
    return [[QPBattlefield f] shareText];
}

- (void)twitterTapped {
    _sharing = true;
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:[self shareText]];
    [vc setCompletionHandler:^(SLComposeViewControllerResult result) {
        _sharing = false;
    }];
    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
}

- (void)facebookTapped {
    _sharing = true;
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:[self shareText]];
    [vc setCompletionHandler:^(SLComposeViewControllerResult result) {
        _sharing = false;
    }];
    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
}

- (void)instagramTapped {
    _sharing = true;
}

- (void)messageTapped {
    _sharing = true;
    MFMessageComposeViewController *vc = [[[MFMessageComposeViewController alloc] init] autorelease];
    vc.messageComposeDelegate = self;
    [vc setBody:[self shareText]];
    [[CCDirector sharedDirector] presentViewController:vc animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [[CCDirector sharedDirector] dismissViewControllerAnimated:true completion:^{
    //play sound
        _sharing = false;
    }];
}

@end