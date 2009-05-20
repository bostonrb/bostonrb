Add tests for:

* since_id: returns tweets with status ids greater than the given id.
* geocode: returns tweets by users located within a given radius of the given latitude/longitude, where the user's location is taken from their Twitter profile.
* show_user: when "true", adds "<user>:" to the beginning of the tweet. This is useful for readers that do not display Atom's author field. The default is "false".
* callback: if supplied, the response will use the JSONP format with a callback of the given name. E.g., http://search.twitter.com/search.json?callback=foo&q=twitter

