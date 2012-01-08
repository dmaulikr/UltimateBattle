//
//  QPFireLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/15/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "cocos2d.h"

@protocol QPFireLayerdelegate;

@interface QPControlLayer : CCLayer

@property (nonatomic, assign) id <QPFireLayerdelegate> delegate;

+(CCScene *) scene;
- (void)addTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;
- (void)endTouch:(CGPoint)l;
-(CGRect)controlRect;

@end

@protocol QPFireLayerdelegate <NSObject>

- (void)fireLayerTapped:(QPControlLayer *)fireLayer;

@end