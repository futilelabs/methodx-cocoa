//
//  MXRequest.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest.h"

@implementation MXRequest

- (id) initWithCommand:(NSString *)command data:(id)data {
  if (self = [self init]) {
    
    self.command = command;
    self.data = data;
    
  }
  return self;
}

@end
