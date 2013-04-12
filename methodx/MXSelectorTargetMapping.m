//
//  MXSelectorTargetMapping.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXSelectorTargetMapping.h"
#import "MXRequest.h"
#import "Macros.h"

@implementation MXSelectorTargetMapping

- (id) initWithCommand:(NSString *)commandName forSelectorName:(NSString *)selectorName onTarget:(id)target {
  if (self = [self init]) {
    
    self.command = commandName;
    self.selectorName = selectorName;
    self.target = target;
    
  }
  return self;
}

- (BOOL)matchesRequest:(MXRequest *)request {
  return [self.command isEqualToString:request.command] || [self.command isEqualToString:MXMappingCatchAllCommand];
}

- (MXResponse *)executeRequest:(MXRequest *)request {
  
  id result;
  
  SuppressPerformSelectorLeakWarning(
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", self.selectorName]);
    result = [self.target performSelector:selector withObject:request];
  );
  
  return result;
  
}

@end
