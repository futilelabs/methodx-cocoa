# MethodX

Project status: Works but won't change the world

## What is this?

MethodX is a simple routing system for mapping incoming commands to actual code.

  * Take a JSON object and run appropriate code in response to it
  * Binary data read from TCP or UDP can in turn execute code in your app
  * Generate commands to send to other MethodX enabled services

### When is it useful?

MethodX is useful when:

  * You are building low-latency network programs
  * You have to respond to incoming requests
  * You have distibuted systems that need to stay in sync
  
### What is already done?

The initial version of MethodX is pretty simple; it has a _router_ class that contains various _mappings_, which will be given control of various _requests_ if they are suitable.

## Get started

You can install MethodX using [CocoaPods](http://cocoapods.org/):

#### 1. Create a new file in your project's root directory called `podfile`

  * A blank text file is fine

#### 2. Add the `MethodX` dependency

For example:

    platform :ios , '6.0'
    pod 'MethodX', :git => "git@github.com:futilelabs/methodx-cocoa.git"
    
#### 3. Install dependencies with pod install

In terminal, do:

    pod install

#### 4. Open the new workspace

#### 5. Use `#import "MethodX.h"` wherever you need MethodX

## Handling incoming requests

Early in your app you would do this:

    // make a router
    MXRouter *router = [[MXRouter alloc] init];
    
    // add some mappings
    [router addMappingForCommand:@"update" forSelectorName:@"doUpdate" onTarget:recordManager];
    [router addMappingForCommand:@"create" forSelectorName:@"doCreate" onTarget:recordManager];
    [router addMappingForCommand:@"sendStats" forSelectorName:@"sendStats" onTarget:statsManager];
    
Then wherever you are receiving commands (from HTTP, TCP, UDP or somewhere else), to get the appropriate code to be executed, you just do this:

    // make a request
    MXRequest *request = [[MXRequest alloc] initWithCommand:theCommand data:theData];
    
    // and tell the router to execute it
    MXResponse *response = [router executeRequest:request];
    
## JSON support

JSON message packages are supported already in the code, and follow this structure:

    { command: data }

For example,

    { update: { id: 1, name: "Mat" } }

When mapped, the above command would execute the `doUpdate` method with `{ id: 1, name: "Mat" }` as the data.

### Using JSON

To use the JSON capabilities, you need to have your raw JSON as an `NSData`, and then you use the `executeRequestsInJSON:` method of the `MXRouter`.  The return value is an array of `MXResponse` objects collected by each request call (see _Multiple commands_ below.)

    NSArray *responses = [router executeRequestsInJSON:rawJSONData];

### Multiple commands

Multiple commands are also supported, which are just normal JSON messages inside a JSON array.

    [
      { "command1": {"name": "Mat"} },
      { "command2": {"name": "Ryan"} },
      { "command3": {"name": "Tim"} }
    ]
    
 The above data would cause `command1` to be executed first, followed by the other commands in the order in which they appear in the array.

### Generating MethodX requests

To generate MethodX requests to send to other places, you can use the `JSONDataFor*` methods on the `MXRequest` class, or the `JSONData` method on an `MXRequest` instance.

The easiest way to generate the JSON to transmit for an existing `MXRequest` instance is to call the `JSONData` method:

    MXRequest *request = [[MXRequest alloc] initForCommand:@"doSomething"];
    NSData *jsonDataToTransmit = [request JSONData]; 
 
If you have an array of request objects, you can use the `JSONDataForRequests:` class method:

    NSData *jsonDataToTransmit = [MXRequest JSONDataForRequests:requestArray];
 
You can avoid creating `MXRequest` objects by using the `JSONDataForCommand:Data:` class helper method:

    NSData *jsonDataToTransmit = [MXRequest JSONDataForCommand:@"doSomething" data:someData];
 
## Adding other formats

### Your own stuff

If you want to add something that will only be useful to you, just write a method that takes in whatever data source you need, generates all the `MXRequest` objects, and calls `[MXRouter executeRequests:]` on them.

#### Category approach

We recommend writing a [category](http://mobile.tutsplus.com/tutorials/iphone/objective-c-categories/) to extend the `MXRouter` and `MXRequest` classes.  You can see how we've done it in the [MXRequest+JSON.h](https://github.com/futilelabs/methodx-cocoa/blob/master/methodx/MXRequest%2BJSON.h) file.

### Generally useful stuff

If you want us to add something specifically, please add an issue, or feel free to fork the repo and add your own stuff directly.  We're very open to pull requests.