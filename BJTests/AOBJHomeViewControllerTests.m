#import "Kiwi.h"


// to test
#import "AOBJHomeViewController.h"


SPEC_BEGIN(AOBJHomeViewControllerTests)

describe(@"APBJViewController", ^{
    __block AOBJHomeViewController *subject;
    
    beforeEach(^{
        subject = [[AOBJHomeViewController alloc] init];
        
        // Force viewDidLoad to be called
        [subject view];
    });
    
    it (@"", ^{
        [[subject shouldNot] beNil];
    });
});


SPEC_END