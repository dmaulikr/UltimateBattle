//
//  KillsLabel.h
//  QuantumPilot
//
//  Created by quantum on 04/01/2015.
//
//

#import "BattleLabel.h"

@interface KillsLabel : BattleLabel {
    int consecutive;
}

- (void)displayText;

@end
