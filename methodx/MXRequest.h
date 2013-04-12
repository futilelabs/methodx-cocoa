//
//  MXRequest.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXRequest : NSObject

- (id) initWithCommand:(NSString *)command data:(id)data;
- (id) initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *command;
@property (nonatomic, strong) id data;

@end
