//
//  Turn.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/4/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Turn : NSObject <NSCopying> {
    
}

@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) BOOL firing;

- (NSString *)mirrorDescription;

@end
