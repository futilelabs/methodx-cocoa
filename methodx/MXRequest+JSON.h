//
//  MXRequest+JSON.h
//  methodx
//
//  Created by Mat Ryer on 12/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import "MXRequest.h"

/**
 Provides JSON specific handling for MethodX.
 */
@interface MXRequest (JSON)

/**
 Generates an NSArray of MXRequest objects from the given JSON NSData.
 */
+ (NSArray *)requestArrayFromJSONData:(NSData *)json;

/**
 Generates JSON NSData for the given command and data.
 */
+ (NSData *)JSONDataForCommand:(NSString *)command andData:(id)data;

/**
 Generates JSON NSData for the given command.  [MXRequest emptyData] will be used.
 */
+ (NSData *)JSONDataForCommand:(NSString *)command;

/**
 Generates JSON NSData for the specified requests.
 */
+ (NSData *)JSONDataForRequests:(NSArray *)requests;

/**
 Gets the JSON NSData for this request.
 */
- (NSData *)JSONData;

@end
