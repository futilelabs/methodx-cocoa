//
//  MXResponse.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXResponse.h"

@implementation MXResponse

+ (MXResponse *) okResponse {
  
  static MXResponse *theOkResponse = nil;
  
  if (theOkResponse == nil) {
    theOkResponse = [[MXResponse alloc] init];
  }
  
  return theOkResponse;
  
}

@end
