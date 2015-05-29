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
      shard: 0
      n_shards: 1

###channel
Tag for this data, get written in the wrapper that gets posted with each message

###data:
Content to post.  Needs to be JSON.stringify-able

###url:
Destination to post messages to


## Events

###log-status gets fired with the response from the service

      postHandler: (event) ->
        @fire "log-status", event.detail

## Methods


      updateFullUrl : ->
        fullUrl = @default_url
        if @url?
          fullUrl = @url
        if @channel?
          if not fullUrl.endsWith("/")
            fullUrl += "/"
          fullUrl += @channel
        fullUrl += "/"
        fullUrl += @shard
        fullUrl += "?no_timestamp=1"
        fullUrl

###postData POSTs data to the service

If you call will no arguments, @data is sent.  Or you can explicitly pass in the data to send.

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

      postData : (obj) ->
        if (!obj?)
          obj = @data
        if obj?
          data = {"channel": @channel,
          "userid": @.$.gcu.username
          "when": new Date().getTime(),
          "url": document.URL,
          "widgetid": @id,
          "version": 1,
          "data": obj}
          @$.ajax.url=@updateFullUrl()
          @$.ajax.body = JSON.stringify(data)
          @$.ajax.go()
        else
          return false




## Polymer Lifecycle

      attached: ->
        @default_url = "https://services.glgresearch.com/logger"
        n_shards = 1
        if Number(@n_shards) > 0
          n_shards = Number(@n_shards)
        @shard = Math.floor(Math.random() * n_shards)
        @postData()
