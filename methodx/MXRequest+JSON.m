//
//  MXRequest+JSON.m
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest+JSON.h"

@implementation MXRequest (JSON)

+ (NSData *)JSONDataFromCommand:(NSString *)command andData:(id)data {
  
  NSDictionary *commandObject = [[NSDictionary alloc] initWithObjectsAndKeys:data, command, nil];
  
  if (![NSJSONSerialization isValidJSONObject:commandObject]) {
    [NSException raise:@"MethodXBadObjectForJSON" format:@"The specified command and data combination produces an unacceptable JSON object.  isValidJSONObject returned NO.  Make sure the [NSJSONSerialization isValidJSONObject:] guidelines are followed."];
  }
  
  NSError *jsonError = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:commandObject options:(NSJSONWritingOptions)0 error:&jsonError];
  
  if (jsonError != nil) {
    [NSException raise:@"MethodXBadObjectForJSON" format:@"The specified command and data combination produces an unacceptable JSON object. [NSJSONSerialization dataWithJSONObject:] returned an error.  Make sure the [NSJSONSerialization isValidJSONObject:] guidelines are followed."];
  }
  
  return jsonData;
  
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
  
  return [NSArray arrayWithArray:requests];
  
}


- (NSData *)JSONData {
  return [MXRequest JSONDataFromCommand:self.command andData:self.data];
}

@end
