//
//  MXRequest_JSONTests.m
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest_JSONTests.h"
#import "methodx.h"

@implementation MXRequest_JSONTests

- (void) testRequestArrayFromJSONString_SingleObject {
  
  NSData *jsonData = [@"{\"command\":{\"name\":\"Mat\"}}" dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *requests = [MXRequest requestArrayFromJSONData:jsonData];
  MXRequest *request = [requests objectAtIndex:0];
  
  STAssertTrue([request.command isEqualToString:@"command"], @"");
  NSDictionary *data = (NSDictionary*)request.data;
  STAssertTrue([[data valueForKey:@"name"] isEqualToString:@"Mat"], @"name");
  
}

- (void) testRequestArrayFromJSONString_ManyObjects {
  
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

- (void) testJSONDataFromCommandAndData {
  
  // make some test objects
  NSString *command = @"command";
  NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:@"Mat", @"name", [NSNumber numberWithInt:30], @"age", nil];
  
  // get the JSON data
  NSData *json = [MXRequest JSONDataFromCommand:command andData:data];
  
  // get the JSON string
  NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
  
  STAssertTrue([jsonString isEqualToString:@"{\"command\":{\"age\":30,\"name\":\"Mat\"}}"], @"JSON string");
  
}

- (void) testJSONData {
  
  // make some test objects
  NSString *command = @"command";
  NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:@"Mat", @"name", [NSNumber numberWithInt:30], @"age", nil];
  
  MXRequest *request = [[MXRequest alloc] initWithCommand:command data:data];
  
  // get the JSON data
  NSData *json = [request JSONData];
  
  // get the JSON string
  NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
  
  STAssertTrue([jsonString isEqualToString:@"{\"command\":{\"age\":30,\"name\":\"Mat\"}}"], @"JSON string");
  
}

@end
