//
//  Clone_PilotAppDelegate.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "cocos2d.h"
#import "Clone_PilotAppDelegate.h"
#import "Clone_PilotViewController.h"
#import "QuantumPilotLayer.h"

@implementation Clone_PilotAppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

#pragma mark cocos2d

- (void) removeStartupFlicker {
    
}

#pragma mark standard

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    self.window.rootViewController = self.viewController;
    
    if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] ) {
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
    }
    
 	CCDirector *director = [CCDirector sharedDirector];
    self.viewController.wantsFullScreenLayout = YES;
    
    EAGLView *glView = [EAGLView viewWithFrame:[self.window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
    
	[director setOpenGLView:glView];
    
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
    
    [director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	[glView setMultipleTouchEnabled:TRUE];    
    [self.viewController setView:glView];
	
    [self.window makeKeyAndVisible];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    CCScene *scene = [CCScene node];
    [scene addChild:[QuantumPilotLayer node]];
    [[CCDirector sharedDirector] runWithScene:scene];    
    
    return YES;
}

#pragma application delegate methods with ccdirector

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
    
    self.viewController = nil;
    self.window = nil;
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
