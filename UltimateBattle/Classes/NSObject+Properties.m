//
//  NSObject+Properties.m
//  ultimatebattle
//
//  Created by X3N0 on 3/21/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>


@implementation NSObject (PropertyListing)

- (NSDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[[NSString alloc] initWithCString:property_getName(property)] autorelease];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


-(id)magicCopy {
	id newObject = [[[[self class] alloc] init] autorelease];
	for (NSString *key in [[self properties_aps] allKeys]) {
		[newObject setValue:[[self properties_aps] valueForKey:key] forKey:key];
	}
	
	return newObject;
}
	


@end