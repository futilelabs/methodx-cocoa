//
//  MXRouter.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMapping.h"

@interface MXRouter : NSObject

- (void) addMapping:(id<MXMapping>)mapping;

- (NSArray *) mappings;

- (void) addMappingForCommand:(NSString *)command forSelectorName:(NSString *)selectorName onTarget:(id)target;

- (id<MXMapping>) firstMappingForRequest:(MXRequest *)request;

- (NSArray *) executeRequests:(NSArray *)requests;

- (MXResponse *) executeRequest:(MXRequest *)request;

- (NSArray *) executeRequestsInJSON:(NSData *)json;

@end
