//
//  MXSelectorTargetMappingTest.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXSelectorTargetMappingTest.h"
#import "MXSelectorTargetMapping.h"
#import "MXResponse.h"
#import "MXRequest.h"

@implementation MXSelectorTargetMappingTest

- (void) testInit {
  
  MXSelectorTargetMapping *mapping = [[MXSelectorTargetMapping alloc] initWithCommand:@"c" forSelectorName:@"testSelector" onTarget:self];
  
  STAssertTrue([mapping.command isEqualToString:@"c"], @"command");
  STAssertEquals(mapping.selectorName, @"testSelector", @"selector");
  STAssertEquals(mapping.target, self, @"target");
  
}

- (void) testMatchesRequestAndExecuteRequest {
  
  MXSelectorTargetMapping *mapping = [[MXSelectorTargetMapping alloc] initWithCommand:@"c" forSelectorName:@"testSelector" onTarget:self];
  
  MXRequest *request = [[MXRequest alloc] initWithCommand:@"c" data:nil];
  
  STAssertTrue([mapping matchesRequest:request], @"matchesRequest?");
  
  // execute the command
  self.testResponse = [[MXResponse alloc] init];
  MXResponse *response = [mapping executeRequest:request];
  
  STAssertEqualObjects(response, self.testResponse, @"response");
  STAssertTrue(self.testSelectorCalled, @"testSelector should be called");
  
}

- (void) testCatchAllRequest {
  
  MXSelectorTargetMapping *mapping = [[MXSelectorTargetMapping alloc] initWithCommand:MXMappingCatchAllCommand forSelectorName:@"catchAll" onTarget:self];
  
  MXRequest *request = [[MXRequest alloc] initWithCommand:@"c" data:nil];
  STAssertTrue([mapping matchesRequest:request], @"matchesRequest?");

  request = [[MXRequest alloc] initWithCommand:@"something" data:nil];
  STAssertTrue([mapping matchesRequest:request], @"matchesRequest?");
  
  request = [[MXRequest alloc] initWithCommand:@"anything" data:nil];
  STAssertTrue([mapping matchesRequest:request], @"matchesRequest?");

}

- (MXResponse *) testSelector:(MXRequest *)request {
  self.testSelectorCalled = YES;
  return self.testResponse;
}

@end
