//
//  ultimatebattleAppDelegate.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ultimatebattleViewController;

@interface ultimatebattleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ultimatebattleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ultimatebattleViewController *viewController;

@end

