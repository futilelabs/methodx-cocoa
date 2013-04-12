//
//  MXRequest.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MXRequest represents a single command, with data.
 */
@interface MXRequest : NSObject

/**
 emptyData is an emoty NSDictionary that should be used when no specific
 data is needed for a command.
 
 Using nil or NSNull will result in the command not being used.
 */
+ (NSDictionary *)emptyData;

/**
 Initializes a request with the specified command and [MXRequest emptyData].
 */
- (id) initWithCommand:(NSString *)command;

/**
 Initializes a request with the specified command and data.
 */
- (id) initWithCommand:(NSString *)command data:(id)data;

/**
 Initialises a request with the specified NSDictionary, which should contain a
 single key representing the command, the value of which becomes the data.
 */
- (id) initWithDictionary:(NSDictionary *)dictionary;

/**
 The command for this request.
 */
@property (nonatomic, copy) NSString *command;

/**
 The data for this request.
 */
@property (nonatomic, strong) id data;

@end
