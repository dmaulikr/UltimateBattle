//
//  ultimatebattleViewController.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"

@interface ultimatebattleViewController : UIViewController {
	int level;
	int currentKills;
}

@property(nonatomic, retain) NSMutableArray *copies;
@property(nonatomic, retain) Ship *player;
@property(nonatomic , retain) NSMutableArray *bullets;

@end

