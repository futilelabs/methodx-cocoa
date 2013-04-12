//
//  MXRouter+JSON.h
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouter.h"

@interface MXRouter (JSON)

/**
 Executes the requests from the specified JSON NSData.
 */
- (NSArray *) executeRequestsInJSON:(NSData *)json;

@end
