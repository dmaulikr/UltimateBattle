#import "Kiwi.h"
#import "QPTouchPointInputLayerHandler.h"

SPEC_BEGIN(QPInputHandlerTests)

describe(@"QPInputHandlerTests", ^{
    __block QPTouchPointInputLayerHandler *h;
    beforeEach(^{
        h = [[[QPTouchPointInputLayerHandler alloc] init] autorelease];
    });
    
    context(@"Input Handling", ^{
        it(@"should have an empty array of handlers", ^{
            [[theValue([[h handlers] count]) should] beZero]; 
        });
    });
});

SPEC_END