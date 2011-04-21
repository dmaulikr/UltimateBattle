//
//  WorstEnemyIpadAppDelegate.h
//  WorstEnemyIpad
//
//  Created by Anthony Broussard on 4/21/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "RootViewController.h"

@class WorstEnemyIpadViewController;

@interface WorstEnemyIpadAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

