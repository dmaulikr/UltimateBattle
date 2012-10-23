//
//  QuantumLayer.h
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "QPBattlefield.h"

@interface QuantumLayer : CCLayer

@property (nonatomic, retain) QPBattlefield *f;
@property (nonatomic, retain) NSTimer *breath;

+ (CCScene *) scene;

@end
