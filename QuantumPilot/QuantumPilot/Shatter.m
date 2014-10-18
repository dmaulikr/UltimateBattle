//
//  Shatter.m
//  QuantumPilot
//
//  Created by quantum on 18/10/2014.
//
//

#import "Shatter.h"
#import "Weapon.h"

@implementation Shatter

- (id)initWithL:(CGPoint)l weapon:(NSString *)w {
    self = [super init];
    self.l = l;

    shipTopHeight = 28;
    shipSideWidth = 8.5;
    shipBottomHeight = 5.75;

    self.yDirection = 1;

    self.weapon = w;
    
    return self;
}

- (void)pulse {
    iteration += 8;
    
    c1[0] = ccp(self.l.x - iteration, self.l.y - shipTopHeight * [self yDirection] - iteration);
    c1[1] = ccp(self.l.x - shipSideWidth - iteration, self.l.y - iteration);

    c2[0] = ccp(self.l.x - shipSideWidth - iteration, self.l.y + iteration);
    c2[1] = ccp(self.l.x - iteration, self.l.y + shipBottomHeight * [self yDirection] + iteration);
    
    c3[0] = ccp(self.l.x + iteration, self.l.y + shipBottomHeight * [self yDirection] + iteration);
    c3[1] = ccp(self.l.x + shipSideWidth + iteration, self.l.y + iteration);

    c4[0] = ccp(self.l.x + shipSideWidth + iteration, self.l.y - iteration);
    c4[1] = ccp(self.l.x + iteration, self.l.y - shipTopHeight * [self yDirection] - iteration);
}

- (void)draw {
    [NSClassFromString(self.weapon) setDrawColor];
    ccDrawPoly(c1, 2, NO);
    ccDrawPoly(c2, 2, NO);
    ccDrawPoly(c3, 2, NO);
    ccDrawPoly(c4, 2, NO);
}

- (bool)dissipated {
    return iteration > 100;
}

- (void)dealloc {
    self.weapon = nil;
    [super dealloc];
}

@end
