# logging-widget
Wraps data with some metadata (timestamp, current user, channel)
and then posts it as JSON to a logging services

## usage:
If ```url``` and ```data``` are both set statically,
the widget will automatically POST when it is ready.

Otherwise, explicitly set them both and then call ```postData()```

## Dependencies

    Polymer 'glg-logging-widget',

##Attributes

###channel
Tag for this data, get written in the wrapper that gets posted with each message

###data:
Content to post.  Needs to be JSON.stringify-able

###url:
Destination to post messages to

      channelChanged : ->
        console.log("Channel is now ", @channel)

      urlChanged : ->
        console.log("Submit url is now ", @url)

## Events

###log-status gets fired with the response from the service

      postHandler: (event) ->
        @fire "log-status", event.detail

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

      postData : ->
        if @data? && @url?
          data = {"channel": @channel,
          "userid": @.$.gcu.username
          "when": new Date().getTime(),
          "version": 1,
          "data": @data}
          console.log("Send ", data, " to ", @url)
          @$.ajax.body = JSON.stringify(data)
          @$.ajax.go()
        else
          return false


## Polymer Lifecycle

      created: ->
        console.log("Created")

      ready: ->
        @postData()
