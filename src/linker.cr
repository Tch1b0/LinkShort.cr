require "./linkshort"

module LinkShort
  class Linker
    getter :short
    getter :destination
    getter :uri
    getter :token

    def initialize(@short : String, @uri : String, @destination : String, @linkshort : LinkShort, @token : String = "")
    end

    # Get the shorcut-url
    def shortcut_url : String
      "#{@uri}#{'/' if !@uri.ends_with? '/'}#{@short}"
    end

    # Call the edit function in the linkshort object with self
    def edit(destination : String)
      @linkshort.edit self, destination
    end

    # Change the value of the destination property
    def set_destination(destination : String) : String
      @destination = destination
    end

    # Edit the destination via the assignment operator
    def destination=(destination : String)
      edit destination
    end

    # Check wether this object is empty
    def empty?
      @short.empty?
    end

    # Check wether this object is the original one and can be edited
    def original? : Bool
      !(@token.empty?)
    end

    # Check wether the destination URI has https or not
    def secure? : Bool
      @destination.starts_with? "https"
    end

    # Parse a Linker object form Hash
    def self.from_h(data : Hash(String, JSON::Any | String), uri : String, linkshort : LinkShort) : Linker
      Linker.new data["short"].to_s, uri, data["destination"].to_s, linkshort, (data.has_key?("token") ? data["token"].to_s : "")
    end

    def to_json
      {
        "short"       => @short,
        "destination" => @destination,
        "uri"         => @uri,
        "token"       => @token,
      }
    end
  end
end
