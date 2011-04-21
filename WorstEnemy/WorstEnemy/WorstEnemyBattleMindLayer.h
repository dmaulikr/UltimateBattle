//
//  WorstEnemyBattleMindLayer.h
//  WorstEnemy
//
//  Created by X3N0 on 4/20/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "WorstEnemyBattlefield.h"

@interface WorstEnemyBattleMindLayer : CCLayer {

}

@property(nonatomic,retain) WorstEnemyBattlefield *battle;

+(CCScene *) scene;

@end
