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

static float topCenter = 0.18f;

@implementation BattleWindow

- (NSArray *)labels {
    return @[self.l1, self.l2, self.l3, self.l4, self.debrisLabel, self.titleLabel, self.subTitle, self.guide, self.speedLabel, self.accuracyLabel, self.pathsLabel, self.killsLabel];
}

- (void)setupLabels {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
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
    self.killsLabel = [[[KillsLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50) size:16] autorelease];
    
    self.weaponLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, height-27, 200, 40)] autorelease];
    self.weaponLabel.textColor = [UIColor whiteColor];
    self.weaponLabel.center = ccp(size.width / 2, 10);
    self.weaponLabel.font = [UIFont boldSystemFontOfSize:16];
    self.weaponLabel.textAlignment = NSTextAlignmentCenter;
    
    self.scoreLabel = [[[ScoreLabel alloc] initWithFrame:CGRectMake(size.width -200, height-27, 200, 40) size:16] autorelease];
    self.scoreLabel.center = ccp(size.width / 2, 30);
    self.scoreLabel.textColor = [UIColor whiteColor];
    //    self.scoreLabel.font = [UIFont boldSystemFontOfSize:16];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    self.accuracyLabel  = [[[AccuracyLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90) size:16] autorelease];
    self.pathsLabel     = [[[PathsLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90) size:16] autorelease];
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
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupLabels];
    [self styleLabels];
    [self setupNotifications];
    self.breath = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(breathe) userInfo:nil repeats:YES];
    return self;
}

//- (void)breathe:(ccTime)deltaTime {
//    _time+= deltaTime;
//    if (_time >= 1) {
//        _time--;
//        [self.scoreLabel pulse];
//        [self.killsLabel pulse];
//        [self.accuracyLabel pulse];
//    }
//}

- (void)breathe {
    [self.scoreLabel pulse];
    [self.killsLabel pulse];
    [self.pathsLabel pulse];
    [self.accuracyLabel pulse];

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
//        self.scoreLabel.font = [UIFont boldSystemFontOfSize:16];
    } else {
        self.scoreLabel.center = ccp(size.width / 2, 45);
        self.scoreLabel.textColor = [UIColor whiteColor];
//        self.scoreLabel.font = [UIFont boldSystemFontOfSize:26];
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
    
    self.accuracyLabel.text = [NSString stringWithFormat:@"%d%%", abs(acc)];
    if ([[n.object objectForKey:@"corner"] boolValue]) {
        self.accuracyLabel.center = ccp(0.1f * size.width, 10);
    //    self.accuracyLabel.font = [UIFont systemFontOfSize:12];
    } else {
        self.accuracyLabel.center = ccp(0.50f * size.width, topCenter * size.height);
//        self.accuracyLabel.font = [UIFont systemFontOfSize:18];
    }
}

- (void)updatePathsLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int paths = [n.object intValue];
    self.pathsLabel.text = [NSString stringWithFormat:@"%d§", abs(paths)];
    
    if (paths >= 0) {
        self.pathsLabel.center = ccp(0.9f * size.width, 10);
      //  self.pathsLabel.font =[UIFont systemFontOfSize:12];
    } else {
        self.pathsLabel.center = ccp(0.75f * size.width, topCenter *  size.height);
    //    self.pathsLabel.font =[UIFont systemFontOfSize:18];
    }
}

- (void)updateKillsLabel:(NSNotification *)n {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int kills = [n.object[@"kills"] intValue];
    if (n.object[@"x"]) {
        self.killsLabel.center = ccp([n.object[@"x"] floatValue], ([n.object[@"y"] floatValue]));
    } else {
        self.killsLabel.center = ccp(0.25f * size.width, topCenter * size.height);
        self.killsLabel.alpha = 1;
        
    }
    
    self.killsLabel.text = [NSString stringWithFormat:@"%dX", abs(kills)];
    self.killsLabel.font =[UIFont systemFontOfSize:18];
}


@end