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

@implementation BattleWindow

- (NSArray *)labels {
    return @[self.l1, self.l2, self.l3, self.l4, self.debrisLabel, self.titleLabel, self.subTitle, self.guide];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.l1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    self.l4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    
    self.debrisLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)] autorelease];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    self.subTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)] autorelease];

    self.guide = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 106, 60)] autorelease];
    
    self.weaponLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 568-27, 200, 40)] autorelease];
    self.weaponLabel.textColor = [UIColor whiteColor];
    self.weaponLabel.font = [UIFont boldSystemFontOfSize:16];
    self.weaponLabel.textAlignment = NSTextAlignmentLeft;
    
    self.scoreLabel = [[[UILabel alloc] initWithFrame:CGRectMake(320-200, 568-27, 200, 40)] autorelease];
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.font = [UIFont boldSystemFontOfSize:16];
    self.scoreLabel.textAlignment = NSTextAlignmentRight;
    
    for (UILabel *l in [self labels]) {
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor whiteColor];
        l.numberOfLines = 0;
        l.lineBreakMode = NSLineBreakByWordWrapping;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:12];
    }
    
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    self.subTitle.font = [UIFont systemFontOfSize:16];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL1:) name:@"L1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL2:) name:@"L2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL3:) name:@"L3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL4:) name:@"L4" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGuide:) name:@"Guide" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDebrisLabel:) name:@"DebrisLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitleLabel:) name:@"TitleLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSubtitleLabel:) name:@"SubtitleLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLabels) name:@"clearLabels" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeaponLabel:) name:@"WeaponLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScoreLabel:) name:@"ScoreLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponLabel" object:[NSNumber numberWithInteger:0]];
    
    return self;
}

- (void)updateWeaponLabel:(NSNotification *)n {
    int i = [n.object intValue];
    Class w = [Arsenal weaponIndexedFromArsenal:i];
    
    self.weaponLabel.text = [w weaponName];
    self.weaponLabel.textColor = [w weaponColor];
}

- (void)updateScoreLabel:(NSNotification *)n {
    self.scoreLabel.text = [n.object stringValue];
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
    self.debrisLabel.center = ccp([d[@"x"] intValue], 578 - [d[@"y"] intValue]); //could post 1, use index
    self.debrisLabel.text = d[@"text"];
}

@end
