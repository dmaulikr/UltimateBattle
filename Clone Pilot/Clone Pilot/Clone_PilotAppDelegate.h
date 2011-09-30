//
//  Clone_PilotAppDelegate.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 9/29/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Clone_PilotViewController;

@interface Clone_PilotAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Clone_PilotViewController *viewController;

@end
