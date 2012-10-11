class window.TwitterWidget
  @dom_cache: ->
    @template = $("#tweet_template")
    @latest_tweets = $("#latest_tweets")
  @callback: (data) ->
    @dom_cache()
    for tweet in data
      @add_tweet(tweet)
  @add_tweet: (tweet) ->
    tweet.text = tweet.text.parseTwitter()
    @print(tweet)
  @print: (tweet) ->
    el = @template.clone().attr("id","")
    el.html(el.html().replace("{{text}}", tweet.text)).show()
    @latest_tweets.append(el)

String::parseUsername = ->
  @replace /[@]+[A-Za-z0-9-_]+/g, (u) ->
    username = u.replace("@", "")
    u.link "http://twitter.com/" + username

String::parseHashtag = ->
  @replace /[#]+[A-Za-z0-9-_]+/g, (t) ->
    tag = t.replace("#", "%23")
    t.link "http://search.twitter.com/search?q=" + tag

String::parseURL = ->
  @replace /[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&~\?\/.=]+/g, (url) ->
    url.link url

String::parseTwitter =->
  @.parseURL().parseHashtag().parseUsername()