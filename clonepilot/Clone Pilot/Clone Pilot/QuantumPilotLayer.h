//
//  QuantumPilotLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 11/25/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ClonePilotBattlefield.h"

@interface QuantumPilotLayer : CCLayer

@property (nonatomic, retain) ClonePilotBattlefield *f;

+(CCScene *) scene;

@end
