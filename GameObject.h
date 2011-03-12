//
//  GameObject.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Turn.h"

@interface GameObject : NSObject {

}

@property(nonatomic) CGPoint vel;
@property(nonatomic) CGPoint l; //location
@property(nonatomic,retain) Turn *turn;

-(void)animate;
-(void)move;
-(void)tick;

@end
