//
//  MXRouterTests.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouterTests.h"
#import "MXRouter.h"
#import "MXSelectorTargetMapping.h"
#import "MXRequest.h"
#import "MXResponse.h"

@implementation MXRouterTests

- (void) testAddMapping {
  
  MXRouter *router = [[MXRouter alloc] init];
  MXSelectorTargetMapping *mapping = [[MXSelectorTargetMapping alloc] initWithCommand:@"command" forSelectorName:@"selector" onTarget:self];
  
  [router addMapping:mapping];
  
  STAssertEquals([router.mappings count], (NSUInteger)1, @"mappings count");
  MXSelectorTargetMapping *theMapping = [router.mappings objectAtIndex:0];
  STAssertTrue([theMapping.command isEqualToString:@"command"], @"command");
  STAssertTrue([theMapping.selectorName isEqualToString:@"selector"], @"selector");
  STAssertEqualObjects(theMapping.target, self, @"target");
  
}

- (void) testAddSelectorTargetMapping {
  
  MXRouter *router = [[MXRouter alloc] init];
  
  [router addMappingForCommand:@"command" forSelectorName:@"selector" onTarget:self];
  
  STAssertEquals([router.mappings count], (NSUInteger)1, @"mappings count");
  MXSelectorTargetMapping *theMapping = [router.mappings objectAtIndex:0];
  STAssertTrue([theMapping.command isEqualToString:@"command"], @"command");
  STAssertTrue([theMapping.selectorName isEqualToString:@"selector"], @"selector");
  STAssertEqualObjects(theMapping.target, self, @"target");

}

- (void) testFirstMappingForCommand {
  
  MXRouter *router = [[MXRouter alloc] init];
  
  MXSelectorTargetMapping *mapping1 = [[MXSelectorTargetMapping alloc] initWithCommand:@"1" forSelectorName:@"selector" onTarget:self];
  MXSelectorTargetMapping *mapping2 = [[MXSelectorTargetMapping alloc] initWithCommand:@"2" forSelectorName:@"selector" onTarget:self];
  MXSelectorTargetMapping *catchallMapping = [[MXSelectorTargetMapping alloc] initWithCommand:@"*" forSelectorName:@"selector" onTarget:self];
  
  [router addMapping:mapping1];
  [router addMapping:mapping2];
  [router addMapping:catchallMapping];

  MXSelectorTargetMapping *command1 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"1" data:nil]];
  STAssertEqualObjects(command1, mapping1, @"command1");

  MXSelectorTargetMapping *command2 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"2" data:nil]];
  STAssertEqualObjects(command2, mapping2, @"command2");

  // test the catch-all special command "*"
  
  MXSelectorTargetMapping *command3 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"3" data:nil]];
  STAssertEqualObjects(command3, catchallMapping, @"catchallMapping");

  MXSelectorTargetMapping *command4 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"random" data:nil]];
  STAssertEqualObjects(command4, catchallMapping, @"catchallMapping");

}

- (void) testExecuteRequest {
  
  MXRouter *router = [[MXRouter alloc] init];
  
  MXSelectorTargetMapping *mapping1 = [[MXSelectorTargetMapping alloc] initWithCommand:@"1" forSelectorName:@"testSelector" onTarget:self];
  MXSelectorTargetMapping *mapping2 = [[MXSelectorTargetMapping alloc] initWithCommand:@"2" forSelectorName:@"testSelector" onTarget:self];
  
  [router addMapping:mapping1];
  [router addMapping:mapping2];
  
  [router executeRequest:[[MXRequest alloc] initWithCommand:@"1" data:nil]];
  
  STAssertTrue(self.testSelectorCalled, @"");
  
}

- (void) testExecuteRequestsInJSON {
  
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
