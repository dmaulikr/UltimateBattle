//
//  QPBattlefieldModifier.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 2/11/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPBattlefieldModifier.h"

@implementation QPBattlefieldModifier

- (void)modifyClonePilotBattlefield:(ClonePilotBattlefield *)f {
}

- (void)modifyBattlefield:(BulletHellBattlefield *)f {
    [self modifyClonePilotBattlefield:(ClonePilotBattlefield *)f];
}

@end
