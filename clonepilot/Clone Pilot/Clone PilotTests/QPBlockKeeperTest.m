//  QPBlockKeeperTest.m

@interface FooValueContainer : NSObject {}

@property (nonatomic, assign) int fooValue;

@end

@implementation FooValueContainer

@synthesize fooValue;

@end

#import "QPBlockKeeper.h"
#import "Kiwi.h"

SPEC_BEGIN(QPBlockKeeperTest)

describe(@"QPBlockKeeperTest", ^{
    it(@"should execute its parameterized block", ^{
        QPBlockKeeper *bk = [[[QPBlockKeeper alloc] init] autorelease];
        
        bk.paramBlock = ^(NSDictionary *d) {
            FooValueContainer *c = [d objectForKey:@"container"];
            NSInteger desiredValue = [[d objectForKey:@"desiredValue"] intValue];
            c.fooValue = desiredValue;
        };
        
        FooValueContainer *fvc = [[[FooValueContainer alloc] init] autorelease];
        NSInteger startingValue = 0;
        fvc.fooValue = startingValue;
        
        NSInteger desiredValue = 5;
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                       fvc, @"container",
                                       [NSNumber numberWithInt:desiredValue], @"desiredValue",
                                       nil];
        bk.executionParams = params;
        
        [[theValue([fvc fooValue]) should] equal:theValue(startingValue)];
        [bk executeWithDefaultParameters];
        [[theValue([fvc fooValue]) should] equal:theValue(desiredValue)];
    });
});

SPEC_END