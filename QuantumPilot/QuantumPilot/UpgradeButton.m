//
//  UpgradeButton.m
//  QuantumPilot
//
//  Created by quantum on 22/01/2015.
//
//

#import "UpgradeButton.h"
#import "cocos2d.h"

@implementation UpgradeButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = true;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.label.center = ccp(frame.size.width / 2, frame.size.height / 2);
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"Copperplate" size:36];
    [self addSubview:self.label];
    [self styleLabel];
    [self setupNotifications];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upgrade)]];
    return self;
}

- (void)styleLabel {
    self.label.textColor = [UIColor whiteColor];
}

- (NSString *)updateNotificationName {
    return nil;
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLabel:)
                                                 name:[self updateNotificationName]
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hide)
                                                 name:@"clearLabels"
                                               object:nil];
    
}

- (void)hide {
//    self.alpha = 0;
}

- (void)upgrade {
    //alert battlefield
}

- (void)updateLabel:(NSNotification *)n {
    [self.superview bringSubviewToFront:self];
    self.alpha = 1;
    self.label.text = n.object;
}
@end
