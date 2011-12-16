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

@interface QuantumPilotLayer : CCLayer {
    NSTimer *timer;
}

@property (nonatomic, retain) ClonePilotBattlefield *f;
@property (nonatomic, retain) CCLabelTTF *dataLabel1;
@property (nonatomic, retain) CCLabelTTF *dataLabel2;
@property (nonatomic, retain) CCLabelTTF *wallLabel;

+(CCScene *) scene;

@end
