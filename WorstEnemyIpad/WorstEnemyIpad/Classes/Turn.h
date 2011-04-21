//
//  Move.h
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Turn : NSObject <NSCopying> {

}

@property(nonatomic) CGPoint l;
@property(nonatomic) CGPoint vel;
@property(nonatomic) CGPoint targetLocation;
@property(nonatomic) BOOL firing;
@property(nonatomic) int weaponIndex;

-(void)becomeEmptyTurn;

@end
