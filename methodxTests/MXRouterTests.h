//
//  MXRouterTests.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class MXRequest;
@class MXResponse;

@interface MXRouterTests : SenTestCase

@property (nonatomic) BOOL testSelectorCalled;
@property (nonatomic) BOOL testSelector2Called;
@property (nonatomic) BOOL testSelector3Called;

- (MXResponse *) testSelector:(MXRequest *)request;
- (MXResponse *) testSelector2:(MXRequest *)request;
- (MXResponse *) testSelector3:(MXRequest *)request;

@end
