//
//  MXRouter+JSON.h
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRouter.h"

@interface MXRouter (JSON)

- (NSArray *) executeRequestsInJSON:(NSData *)json;

@end
