//
//  AppDelegate.h
//  QuantumPilot
//
//  Created by X3N0 on 10/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "BattleWindow.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate> {
	BattleWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) BattleWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;


@end
