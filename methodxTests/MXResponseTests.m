//
//  MXResponseTests.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXResponseTests.h"
#import "methodx.h"

@implementation MXResponseTests

- (void) testDefaultResponse {
  
  STAssertNotNil([MXResponse okResponse], @"okResponse");
  
}

@end
