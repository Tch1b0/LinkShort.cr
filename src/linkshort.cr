require "./linker"
require "./requester"

module LinkShort
  VERSION = "0.1.0"

  class LinkShort
    @uri : URI

    def initialize(@base_uri : String = "https://ls.johannespour.de")
      @uri = URI.parse @base_uri
      @requester = Requester.new @uri
    end

    # Get all shortcuts
    def all : Array
      res = @requester.get("links")
      linker_arr = [] of Linker
      res.each_key do |key|
        data = {
          "short"       => key,
          "destination" => res[key],
        }
        linker_arr << Linker.from_h data, @base_uri, self
      end
      linker_arr
    end

    # Get a shortcut by its id
    def from_id(id : String) : Linker
      Linker.from_h @requester.get("#{id}/json"), @base_uri, self
    end

    # Create a new shorctu
    def create(destination : String) : Linker
      data = {
        "link" => destination,
      }
      res = @requester.post("create", data)
      res["destination"] = JSON::Any.new destination
      Linker.from_h res, @base_uri, self
    end

    # Edit the destination of a shortcut
    def edit(linker : Linker, destination) : Linker
      raise("Unauthorized: The token is missing") if !linker.original?

      data = {
        "link"  => destination,
        "token" => linker.token,
      }
      @requester.put(linker.short, data)
      linker.set_destination destination
      linker
    end
  end
end
