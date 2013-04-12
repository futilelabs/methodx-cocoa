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
  
  [router addMapping:mapping1];
  [router addMapping:mapping2];

  MXSelectorTargetMapping *command1 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"1" data:nil]];
  STAssertEqualObjects(command1, mapping1, @"command1");

  MXSelectorTargetMapping *command2 = [router firstMappingForRequest:[[MXRequest alloc] initWithCommand:@"2" data:nil]];
  STAssertEqualObjects(command2, mapping2, @"command2");

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

- (MXResponse *) testSelector:(MXRequest *)request {
  self.testSelectorCalled = YES;
  return nil;
}

@end
