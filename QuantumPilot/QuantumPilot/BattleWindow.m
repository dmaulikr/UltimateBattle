//
//  BattleWindow.m
//  QuantumPilot
//
//  Created by quantum on 13/10/2014.
//
//

#import "BattleWindow.h"
#import "cocos2d.h"

@implementation BattleWindow

- (NSArray *)labels {
    return @[self.l1, self.l2, self.l3, self.l4, self.debrisLabel, self.titleLabel, self.subTitle];
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

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel:) name:@"label" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDebrisLabel:) name:@"DebrisLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitleLabel:) name:@"TitleLabel" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSubtitleLabel:) name:@"SubtitleLabel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLabels) name:@"clearLabels" object:nil];
    
    return self;
}

//- (void)updateLabel:(NSNotification *)n {
//    NSDictionary *d = n.object;
//    int index = [d[@"index"] intValue];
//    UILabel *l = [self labels][index];
//    l.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
//    l.text = d[@"text"];
//}

- (void)updateTitleLabel:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.titleLabel.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.titleLabel.text = d[@"text"];
}

- (void)updateSubtitleLabel:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.subTitle.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.subTitle.text = d[@"text"];
}



- (void)updateL1:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.l1.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.l1.text = d[@"text"];
}

- (void)updateL2:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.l2.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.l2.text = d[@"text"];
}

- (void)updateL3:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.l3.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.l3.text = d[@"text"];
}

- (void)updateL4:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.l4.center = ccp([d[@"x"] intValue], [d[@"y"] intValue]);
    self.l4.text = d[@"text"];
}

- (void)hideLabels {
    for (UILabel *l in [self labels]) {
        l.center = ccp(5000,5000);
    }
}

- (void)updateDebrisLabel:(NSNotification *)n {
    NSDictionary *d = n.object;
    self.debrisLabel.center = ccp([d[@"x"] intValue], 578 - [d[@"y"] intValue]); //could post 1, use index
    self.debrisLabel.text = d[@"text"];
}

@end
