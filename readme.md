# logging-widget
Wraps data with some metadata (timestamp, current user, channel)
and then posts it as JSON to a logging services

## usage:
If ```url``` and ```data``` are both set statically,
the widget will automatically POST when it is ready.

Otherwise, explicitly set them both and then call ```postData()```

##Attributes

###channel
Tag for this data, get written in the wrapper that gets posted with each message

###data:
Content to post.  Needs to be JSON.stringify-able

###url:
Destination to post messages to

## Events

###log-status gets fired with the response from the service

## Methods

###postData POSTs data to the service

Example:

```
@channel = "my-app";
@data = {
    "xyz": 999
}
```

The posted data could look like this:
```
{
  "channel": "my-app",
  "version": 1,
  "when": 1432754561620,
  "data": {
      "xyz": 999
  }
}
```
