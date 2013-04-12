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

@interface MXSelectorTargetMapping : NSObject<MXMapping>

- (id) initWithCommand:(NSString *)commandName forSelectorName:(NSString *)selectorName onTarget:(id)target;

@property (nonatomic, copy) NSString *command;
@property (nonatomic, copy) NSString *selectorName;
@property (nonatomic, weak) id target;

@end
