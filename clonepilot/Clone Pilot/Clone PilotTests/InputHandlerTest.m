#import "Kiwi.h"
#import "QPTouchPointInputLayerHandler.h"
#import "QPMoveInputHandler.h"

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
        
        it(@"should accept an input handler", ^{
            QPMoveInputHandler *ih = [[[QPMoveInputHandler alloc] init] autorelease];
            [h addHandler:ih];
            [[theValue([[h handlers] count]) should] equal:theValue(1)];
        });
        
        it(@"should be able to execute its handler completion blocks with params", ^{
            QPMoveInputHandler *ih = [[[QPMoveInputHandler alloc] init] autorelease];
        });
    });
});

SPEC_END