//
//  MXRouter_JSONTests.m
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouter_JSONTests.h"
#import "methodx.h"

@implementation MXRouter_JSONTests

- (void) testExecuteRequestsInJSON {
  
  self.testSelectorCalled = NO;
  self.testSelector2Called = NO;
  self.testSelector3Called = NO;
  
  MXRouter *router = [[MXRouter alloc] init];
  
  MXSelectorTargetMapping *mapping1 = [[MXSelectorTargetMapping alloc] initWithCommand:@"command" forSelectorName:@"testSelector" onTarget:self];
  MXSelectorTargetMapping *mapping2 = [[MXSelectorTargetMapping alloc] initWithCommand:@"command2" forSelectorName:@"testSelector2" onTarget:self];
  MXSelectorTargetMapping *mapping3 = [[MXSelectorTargetMapping alloc] initWithCommand:@"*" forSelectorName:@"testSelector3" onTarget:self];
  
  [router addMapping:mapping1];
  [router addMapping:mapping2];
  [router addMapping:mapping3];
  
  NSData *jsonData = [@"[{\"command\":{\"name\":\"Mat\"}},{\"command2\":{\"name\":\"Ryan\"}},{\"something\":{\"name\":\"Tim\"}}]" dataUsingEncoding:NSUTF8StringEncoding];
  
  NSArray *responses = [router executeRequestsInJSON:jsonData];
  
  STAssertTrue(self.testSelectorCalled, @"");
  STAssertTrue(self.testSelector2Called, @"");
  STAssertTrue(self.testSelector3Called, @"");
  
  STAssertEquals([responses count], (NSUInteger)3, @"Should collect responses");
  
}

- (MXResponse *) testSelector:(MXRequest *)request {
  self.testSelectorCalled = YES;
  return [[MXResponse alloc] init];
}
- (MXResponse *) testSelector2:(MXRequest *)request {
  self.testSelector2Called = YES;
  return [[MXResponse alloc] init];
}
- (MXResponse *) testSelector3:(MXRequest *)request {
  self.testSelector3Called = YES;
  return [[MXResponse alloc] init];
}

@end
