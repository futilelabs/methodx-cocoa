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

- (MXResponse *) testSelector:(MXRequest *)request;

@end
