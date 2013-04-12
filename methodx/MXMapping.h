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

@protocol MXMapping <NSObject>

@required

- (BOOL) matchesRequest:(MXRequest*)request;

- (MXResponse *) executeRequest:(MXRequest *)request;

@end
