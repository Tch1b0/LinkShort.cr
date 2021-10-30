require "http/client"
require "json"

module LinkShort
  class Requester
    def initialize(@uri : URI = URI.parse("https://ls.johannespour.de"))
    end

    # Make a `get` request to the specified url + path
    def get(path : String) : Hash(String, JSON::Any)
      @uri.path = path
      parse_response HTTP::Client.get(@uri.to_s)
    end

    # Make a `post` request to the specified url + path
    def post(path : String, data : Hash(String, String)) : Hash(String, JSON::Any)
      @uri.path = path
      headers = HTTP::Headers.new.add "Content-type", "application/json"
      parse_response HTTP::Client.post(@uri.to_s, body: data.to_json, headers: headers)
    end

    # Make a `put` request to the specified url + path
    def put(path : String, data : Hash(String, String)) : Hash(String, JSON::Any)
      @uri.path = path
      headers = HTTP::Headers.new.add "Content-type", "application/json"
      parse_response HTTP::Client.put(@uri.to_s, body: data.to_json, headers: headers)
    end

    private def parse_response(res) : Hash(String, JSON::Any)
      if res.body.size > 0
        return JSON.parse(res.body).as_h
      end
      {} of String => JSON::Any
    end
  end
end
