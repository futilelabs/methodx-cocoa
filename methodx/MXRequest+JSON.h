//
//  MXRequest+JSON.h
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest.h"

@interface MXRequest (JSON)

+ (NSArray *)requestArrayFromJSONData:(NSData *)json;

+ (NSData *)JSONDataForCommand:(NSString *)command andData:(id)data;

+ (NSData *)JSONDataForRequests:(NSArray *)requests;

- (NSData *)JSONData;

@end
