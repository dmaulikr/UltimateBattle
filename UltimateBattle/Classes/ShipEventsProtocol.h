//
//  ShipEventsProtocol
//  ultimatebattle
//
//  Created by X3N0 on 3/19/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UltimateShip.h"


@protocol ShipEventsProtocol

-(void)destroyed:(UltimateShip *)ship;

@end