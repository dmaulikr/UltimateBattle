//
//  WeaponSelector.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/22/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplitLaser.h"
#import "TriLaser.h"
#import "ClonePlayer.h"

@protocol WeaponSelectorDelegate <NSObject>

- (NSInteger)level;
- (ClonePlayer *)player;
- (void)playerChoseWeapon:(Weapon *)weapon;

@end

@interface WeaponSelector : NSObject



@property (nonatomic, retain) NSArray *weaponChoices;
@property (nonatomic, retain) NSMutableArray *chosenWeapons;
@property (nonatomic, retain) SplitLaser *splitLaser;
@property (nonatomic, retain) TriLaser *triLaser;

@property (nonatomic, assign) id <WeaponSelectorDelegate> delegate;

- (id)initWithBattlefield:(id)field;
- (void)chooseWeapon:(NSInteger)choiceIndex;
- (void)openWeaponOptions;

@end