//
//  NSObject+Properties.h
//  ultimatebattle
//
//  Created by X3N0 on 3/21/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Properties)

// aps suffix to avoid namespace collsion
//   ...for Andrew Paul Sardone
- (NSDictionary *)properties_aps;
-(id)magicCopy;

@end
