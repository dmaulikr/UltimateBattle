//
//  QPBattlefield.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "CCNode.h"

@interface QPBattlefield : CCNode

@property (nonatomic) float rhythmScale;
@property (nonatomic) NSInteger rhythmDirection;
@property (nonatomic) float rhythmGrowth;

- (void)tick;

+ (QPBattlefield *)f;

+ (float)rhythmScale;

@end
