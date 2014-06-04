#import "Kiwi.h"


// to test
#import "AOBJHelper.h"


SPEC_BEGIN(AOBJHelperTests)

describe(@"AOBJHelper", ^{
    
    describe(@"+levelByChips:", ^{
       
        it(@"returns level 1 given 100 chips", ^{
            [[[AOBJHelper levelByChips:@"100"]should] equal:@"1"];
        });
        
        it(@"returns level 2 given 101 chips", ^{
            [[[AOBJHelper levelByChips:@"101"]should] equal:@"2"];
        });
    });
});

SPEC_END