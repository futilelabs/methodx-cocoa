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

@end
