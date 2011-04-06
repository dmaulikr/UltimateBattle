//
//  cmpgames.h
//  coop
//
//  Created by X3N0 on 7/18/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>



float distvar, distvar2, fdist, veldistance;
CGPoint fvel;


CGPoint CombineVel(CGPoint v1, CGPoint v2);
float GetDist(CGPoint initialp, CGPoint secondp);
CGPoint GetAngle(CGPoint initialp ,CGPoint secondp);
CGPoint MultiplyVel(CGPoint cref , float mfact);
BOOL OutOfBounds(CGPoint initialp);
CGPoint IXncreaseX(CGPoint v1, float xv);
CGPoint IYncreaseY(CGPoint v1, float yv);
CGPoint SXetX(CGPoint v1, float x);
CGPoint SYetY(CGPoint v1, float y);
CGPoint SXOffsetX(CGPoint v1, float x);
CGPoint SYOffsetY(CGPoint v1, float y);