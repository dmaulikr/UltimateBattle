//
//  QPFireLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/15/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "cocos2d.h"

@protocol QPFireLayerdelegate;

@interface QPFireLayer : CCLayer

@property (nonatomic, assign) id <QPFireLayerdelegate> delegate;

+(CCScene *) scene;
- (void)addTouch:(CGPoint)l;

@end

@protocol QPFireLayerdelegate <NSObject>

- (void)fireLayerTapped:(QPFireLayer *)fireLayer;

@end