//
//  MXRouter.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMapping.h"

/**
 MXRouter is responsible for routing MXRequest commands to real code.
 */
@interface MXRouter : NSObject

/**
 addMapping adds the specified <MXMapping> object to the route table.
 
 If you're using MXSelectorTargetMapping objects, then just use the addMappingForCommand:forSelectorName:onTarget helper instead.
 */
- (void) addMapping:(id<MXMapping>)mapping;

/**
 Gets the mappings in this router.
 */
- (NSArray *) mappings;

/**
 Adds a MXSelectorTargetMapping object to this router.
 */
- (void) addMappingForCommand:(NSString *)command forSelectorName:(NSString *)selectorName onTarget:(id)target;

/**
 Gets the first MXMapping object that answers YES (when asked matchesRequest:) for the
 specified request.
 */
- (id<MXMapping>) firstMappingForRequest:(MXRequest *)request;

/**
 Executes all requests in the specified array, in the order in which they appear.
 */
- (NSArray *) executeRequests:(NSArray *)requests;

/**
 Executes the specified request.
 */
- (MXResponse *) executeRequest:(MXRequest *)request;

@end
