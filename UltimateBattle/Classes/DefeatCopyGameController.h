//
//  DefeatCopyGameController.h
//  ultimatebattle
//
//  Created by X3N0 on 3/19/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShipEventsProtocol.h"

@interface DefeatCopyGameController : NSObject <ShipEventsProtocol> {

}

@property(nonatomic,retain) NSMutableArray *copies;

@end
