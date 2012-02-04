//
//  WeaponSelector.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/22/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClonePlayer.h"
#import "SingleLaser.h"
#import "SplitLaser.h"
#import "TriLaser.h"
#import "QuadLaser.h"
#import "SideLaser.h"
#import "WideTriLaser.h"

@protocol WeaponSelectorDelegate <NSObject>

- (NSInteger)level;
- (ClonePlayer *)player;
- (void)playerChoseWeapon:(Weapon *)weapon;

@end

@interface WeaponSelector : NSObject



@property (nonatomic, retain) NSArray *weaponChoices;
@property (nonatomic, retain) NSMutableArray *chosenWeapons;
@property (nonatomic, retain) SingleLaser *singleLaser;
@property (nonatomic, retain) SplitLaser *splitLaser;
@property (nonatomic, retain) TriLaser *triLaser;
@property (nonatomic, retain) QuadLaser *quadLaser;
@property (nonatomic, retain) SideLaser *sideLaser;
@property (nonatomic, retain) WideTriLaser *wideTriLaser;

@property (nonatomic, assign) id <WeaponSelectorDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *optionLayers;

- (id)initWithBattlefield:(id)field;
- (void)startup;
- (void)restart;

- (void)chooseWeapon:(NSInteger)choiceIndex;
- (void)openWeaponOptions;

- (void)addWeaponOptionLayersToLayer:(CCLayer *)layer;

- (BOOL)presentingOptions;

@end