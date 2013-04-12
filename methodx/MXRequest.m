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

+ (NSArray *)requestArrayFromJSONData:(NSData *)json {
  
  NSError *error = nil;
  id data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
  
  if (error != nil) {
    [NSException raise:@"MXRequestBadJSON" format:@"MXRequest initWithJSONData failed: %@", error];
  }
  
  NSMutableArray *requests = [[NSMutableArray alloc] init];
  
  if ([data isKindOfClass:[NSArray class]]) {
    
    // collection of objects
    [(NSArray*)data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [requests addObject:[[MXRequest alloc] initWithDictionary:obj]];
    }];
    
  } else if ([data isKindOfClass:[NSDictionary class]]) {
    
    // single object
    [requests addObject:[[MXRequest alloc] initWithDictionary:data]];
    
  } else {
    
    // other kind of value
    
    [NSException raise:@"MXRequestBadData" format:@"Data expected to be either a dictionary or an array of dictionaries, not %@.", [data class]];
    
  }
  
  return requests;
  
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

/*
- (id) initWithJSONData:(NSData *)json {
  
  NSError *error = nil;
  id data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
  
  if (error != nil) {
    [NSException raise:@"MXRequestBadJSON" format:@"MXRequest initWithJSONData failed: %@", error];
  }
  
  NSDictionary *dictData = (NSDictionary *)data;
  
  // get the first key
  NSArray *keys = [dictData allKeys];
  
  if ([keys count] != 1) {
    [NSException raise:@"MXRequestBadJSON" format:@"MXRequest initWithJSONData failed: Command expected to be the only key in the object.  Got %d keys.", [keys count]];
  }
  
  NSString *command = [keys objectAtIndex:0];
  id commandData = [dictData objectForKey:command];
    
  return (self = [self initWithCommand:command data:commandData]);

}
*/

@end
