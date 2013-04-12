//
//  MXRouter+JSON.m
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouter+JSON.h"
#import "MXRequest.h"
#import "MXRequest+JSON.h"

@implementation MXRouter (JSON)

- (NSArray *) executeRequestsInJSON:(NSData *)json {
  return [self executeRequests:[MXRequest requestArrayFromJSONData:json]];
}

@end
