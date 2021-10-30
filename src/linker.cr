require "./linkshort"

module LinkShort
  # The representation of the `shortcut` resource
  class Linker
    # Get the `short` property
    getter :short

    # Get the `destination` property
    getter :destination

    # Get the `uri` property
    getter :uri

    # Get the `token` property
    getter :token

    # Set the `short` property
    setter :short

    def initialize(@short : String, @uri : String, @destination : String, @linkshort : LinkShort, @token : String = "")
    end

    # Returns the shorctu url, with which the shortcut can be used
    def shortcut_url : String
      "#{@uri}#{'/' if !@uri.ends_with? '/'}#{@short}"
    end

    # Update this object to the current state
    def update
      linker = @linkshort.from_short @short
      if @destination != linker.destination
        set_destination linker.destination
      end
    end

    # Shorcut for `LinkShort.edit`
    def edit(destination : String)
      @linkshort.edit self, destination
    end

    # Shorcut for `Linker.delete`
    def delete
      @linkshort.delete self
    end

    # Change the value of the destination property without triggering the `edit` function
    def set_destination(destination : String) : String
      @destination = destination
    end

    # Edit the destination via the assignment operator
    def destination=(destination : String)
      edit destination
    end

    # Compare this `Linker` with another `Linkere`
    def ==(other : Linker)
      @short == other.short
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

    # Check wether the shorcut can still be used
    def active? : Bool
      !@short.empty?
    end

    # Parse a `Linker` object from a `Hash`
    def self.from_h(data : Hash(String, JSON::Any | String), uri : String, linkshort : LinkShort) : Linker
      Linker.new data["short"].to_s, uri, data["destination"].to_s, linkshort, (data.has_key?("token") ? data["token"].to_s : "")
    end

    # Returns the JSON representation of this object
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
