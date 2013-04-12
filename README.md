# MethodX

## What is this?

MethodX is a simple routing system for mapping incoming commands to actual code.

  * Take a JSON object and appropriate code in response to it
  * Binary data read from TCP or UDP can in turn execute code in your app

### When is it useful?

MethodX is useful when:

  * You are building low-latency network programs
  * You have to respond to incoming requests
  * You have distibuted systems that need to stay in sync
  
### What is already done?

The initial version of MethodX is pretty simple; it has a _router_ class that contains various _mappings_, which will be given control of various _requests_ if they are suitable.

## Usage

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
    
## JSON is supported today

JSON message packages are supported already in the code, and follow this structure:

    { command: data }

For example,

    { update: { id: 1, name: "Mat" } }

When mapped, the above command would execute the `doUpdate` selector with `{ id: 1, name: "Mat" }` as the data.

### Usage

To use the JSON capabilities, you need to have your raw JSON as an `NSData`, and then you use the `executeRequestsInJSON:` selector of the `MXRouter`.  The return value is an array of `MXResponse` objects collected by each request call (see _Multiple commands_ below.)

    NSArray *responses = [router executeRequestsInJSON:rawJSONData];

### Multiple commands

Multiple commands are also supported which are just normal JSON messages inside an array.

    [
      { "command1": {"name": "Mat"} },
      { "command2": {"name": "Ryan"} },
      { "command3": {"name": "Tim"} }
    ]
    
 The above data would cause `command1` to be executed first, followed by the other commands in the order in which they appear in the array.
 
## Adding support

### Your own stuff

If you want to add something that will only be useful to you, just write a method that takes in whatever data source you need, generate all the `MXRequest` objects, and call `[MXRouter executeRequests:]`.

### Generally useful stuff

If you want us to add something specifically, please add an issue, or feel free to fork the repo and add your own stuff directly.  We're very open to pull requests.