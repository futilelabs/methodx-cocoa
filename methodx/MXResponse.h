//
//  MXResponse.h
//  methodx
//
//  Created by Mat Ryer on 11/04/2013.
//  Copyright (c) 2013 futilegames.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MXResponse is the base class for any responses to the commands.
 */
@interface MXResponse : NSObject

/**
 okResponse represents a simple response that indicates that everything is OK.
 
 If you don't care about responses, it is good practice to return this object from inside
 handler code.
 */
+ (MXResponse *) okResponse;

@end
