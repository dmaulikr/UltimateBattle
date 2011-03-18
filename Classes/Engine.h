//
//  Engine.h
//  ultimatebattle
//
//  Created by Anthony Broussard on 3/18/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject {
    
}

@property(nonatomic) CGRect movementBounds;
@property(nonatomic) float speed;

-(CGPoint)moveFrom:(CGPoint )l withVel:(CGPoint)vel;
-(CGPoint)velocityForTargetPoint:(CGPoint)target from:(CGPoint)location;

@end