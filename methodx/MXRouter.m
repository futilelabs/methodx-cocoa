//
//  MXRouter.m
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouter.h"
#import "MXSelectorTargetMapping.h"

@interface MXRouter ()
@property (nonatomic, strong) NSMutableArray *internalMappings;
@end

@implementation MXRouter

- (id) init {
  if (self = [super init]) {
    self.internalMappings = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void) addMapping:(id<MXMapping>)mapping {
  [self.internalMappings addObject:mapping];
}

- (NSArray *) mappings {
  return [NSArray arrayWithArray:self.internalMappings];
}

- (void) addMappingForCommand:(NSString *)command forSelectorName:(NSString *)selectorName onTarget:(id)target {
  
  [self addMapping:[[MXSelectorTargetMapping alloc] initWithCommand:command forSelectorName:selectorName onTarget:target]];
  
}

- (id<MXMapping>) firstMappingForRequest:(MXRequest *)request {

  __block id<MXMapping> foundMapping = nil;
  
  [self.internalMappings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([(id<MXMapping>)obj matchesRequest:request]) {
      
      foundMapping = obj;
      
      *stop = YES;
    }
  }];
  
  return foundMapping;

}

- (MXResponse *) executeRequest:(MXRequest *)request {
  
  id<MXMapping> mapping = [self firstMappingForRequest:request];
  
  if (mapping == nil) {
    [NSException raise:@"NoMapping" format:@"methodx: No mapping found for request %@", request];
  }
  
  return [mapping executeRequest:request];
  
}

@end
