//
//  MXRequest.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest.h"

@implementation MXRequest

- (id) initWithCommand:(NSString *)command {
  if (self = [self initWithCommand:command data:[MXRequest emptyData]]) {
  }
  return self;
}

- (id) initWithCommand:(NSString *)command data:(id)data {
  if (self = [self init]) {
    
    self.command = command;
    self.data = data;
    
  }
  return self;
}

- (id) initWithDictionary:(NSDictionary *)dictionary {
  
  // dictionary should have one key
  NSArray *keys = dictionary.allKeys;
  if ([keys count] != 1) {
    [NSException raise:@"MXRequestBadDictionary" format:@"MXRequest initWithDictionary failed: The dictionary should have one key, the command."];
  }
  
  // get the command
  NSString *command = [keys objectAtIndex:0];
  
  // get the command data
  id commandData = [dictionary valueForKey:command];
  
  return (self = [self initWithCommand:command data:commandData]);
  
}

- (void) setData:(id)data {
  
  // ensure it's not nil
  if (data == nil) {
    data = [MXRequest emptyData];
  }
  
  // set the data
  _data = data;
  
}

+ (NSDictionary *)emptyData {
  
  static NSDictionary *emptyData = nil;
  
  if (emptyData == nil) {
    emptyData = [[NSDictionary alloc] init];
  }
  
  return emptyData;
  
}

@end
