//
//  MXSelectorTargetMappingTest.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class MXResponse;
@class MXRequest;

@interface MXSelectorTargetMappingTest : SenTestCase

@property (nonatomic) BOOL testSelectorCalled;

@property (nonatomic, strong) MXResponse *testResponse;

- (MXResponse *) testSelector:(MXRequest *)request;

@end
