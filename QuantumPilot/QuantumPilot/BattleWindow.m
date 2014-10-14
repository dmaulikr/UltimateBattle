//
//  BattleWindow.m
//  QuantumPilot
//
//  Created by quantum on 13/10/2014.
//
//

#import "BattleWindow.h"

@implementation BattleWindow

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.l1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
    self.l2 = [[UILabel alloc] initWithFrame:CGRectMake(270, 100, 200, 30)];
    self.l3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 300, 200, 30)];
    self.l4 = [[UILabel alloc] initWithFrame:CGRectMake(270, 300, 200, 30)];
    
    for (UILabel *l in @[self.l1, self.l2, self.l3, self.l4]) {
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor whiteColor];
        [self addSubview:l];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateL1:) name:@"L1" object:nil];
    
    return self;
}

- (void)updateL1:(NSNotification *)n {
    self.l1.text = n.object;
}

@end
