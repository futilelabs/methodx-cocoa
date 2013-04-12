//
//  MXMapping.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MXRequest;
@class MXResponse;

/**
 MXMapping represents an object capable of mapping an MXRequest to executable code.
 
 If you want to map to an existing selector and target pair, use the MXSelectorTargetMapping implementation.
 */
@protocol MXMapping <NSObject>

@required

/**
 Gets whether this mapping matches the request, and therefore should executeRequest
 be called.
 */
- (BOOL) matchesRequest:(MXRequest*)request;

/**
 Executes code to handle the request if matchesRequest returns YES.
 */
- (MXResponse *) executeRequest:(MXRequest *)request;

@end
