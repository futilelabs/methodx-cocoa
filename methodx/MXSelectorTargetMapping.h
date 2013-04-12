//
//  MXSelectorTargetMapping.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMapping.h"

#define MXMappingCatchAllCommand @"*"

/**
 MXSelectorTargetMapping is an MXMapping that is capable of calling a selector on a
 target.  This is the most common kind of mapping.
 */
@interface MXSelectorTargetMapping : NSObject<MXMapping>

- (id) initWithCommand:(NSString *)commandName forSelectorName:(NSString *)selectorName onTarget:(id)target;

/**
 The command name to map to.
 */
@property (nonatomic, copy) NSString *command;

/**
 The name of the selector on target that will be mapped.
 
 The selector must have the signature:
 
   (MXResponse *) doSomething:(MXRequest *)request;
 
 In this case, the value for selectorName would just be "doSomething".
 
 */
@property (nonatomic, copy) NSString *selectorName;

/**
 The target on which the selector will be called.
 */
@property (nonatomic, weak) id target;

@end
