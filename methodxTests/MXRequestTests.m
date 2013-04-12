//
//  MXRequestTests.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequestTests.h"
#import "MXRequest.h"

@implementation MXRequestTests

- (void) testInit {
  
  NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:@"", @"", nil];
  MXRequest *request = [[MXRequest alloc] initWithCommand:@"command" data:data];
  
  STAssertEqualObjects(request.command, @"command", @"command");
  STAssertEqualObjects(request.data, data, @"data");
  
}

- (void) requestArrayFromJSONString_SingleObject {
  
  NSData *jsonData = [@"{\"command\":{\"name\":\"Mat\"}}" dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *requests = [MXRequest requestArrayFromJSONData:jsonData];
  MXRequest *request = [requests objectAtIndex:0];
  
  STAssertTrue([request.command isEqualToString:@"command"], @"");
  NSDictionary *data = (NSDictionary*)request.data;
  STAssertTrue([[data valueForKey:@"name"] isEqualToString:@"Mat"], @"name");
  
}

- (void) requestArrayFromJSONString_ManyObjects {
  
  NSData *jsonData = [@"[{\"command\":{\"name\":\"Mat\"}},{\"command2\":{\"name\":\"Ryan\"}}]" dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *requests = [MXRequest requestArrayFromJSONData:jsonData];
  
  MXRequest *request = [requests objectAtIndex:0];
  STAssertTrue([request.command isEqualToString:@"command"], @"");
  NSDictionary *data = (NSDictionary*)request.data;
  STAssertTrue([[data valueForKey:@"name"] isEqualToString:@"Mat"], @"name");

  request = [requests objectAtIndex:1];
  STAssertTrue([request.command isEqualToString:@"command2"], @"");
  data = (NSDictionary*)request.data;
  STAssertTrue([[data valueForKey:@"name"] isEqualToString:@"Ryan"], @"name");

}

@end
