//
//  Arsenal.h
//  QuantumPilot
//
//  Created by quantum on 01/10/2014.
//
//

#import <Foundation/Foundation.h>

@interface Arsenal : NSObject

+ (NSArray *)arsenal;
+ (NSArray *)upgradeArsenal;
+ (Class)weaponIndexedFromArsenal:(int)i;

@end
