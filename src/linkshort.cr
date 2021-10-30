require "./linker"
require "./requester"

module LinkShort
  VERSION = "0.1.0"

  # Represents the LinkShort API.
  # Is used for making requests and managing the `Linker` objects
  class LinkShort
    @uri : URI

    getter :base_uri

    def initialize(@base_uri : String = "https://ls.johannespour.de")
      @uri = URI.parse @base_uri
      @requester = Requester.new @uri
    end

    # Get all `Linker` objects
    def all : Array(Linker)
      res = @requester.get "links"
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

    # Get a `Linker` by its `id`
    def from_id(id : String) : Linker
      Linker.from_h @requester.get("#{id}/json"), @base_uri, self
    end

    # Create a new `Linker` from a destination
    def create(destination : String) : Linker
      data = {
        "link" => destination,
      }
      res = @requester.post "create", data
      res["destination"] = JSON::Any.new destination
      Linker.from_h res, @base_uri, self
    end

    # Edit the destination of a `Linker`
    def edit(linker : Linker, destination) : Linker
      raise("Unauthorized: The token is missing") if !linker.original?

      data = {
        "link"  => destination,
        "token" => linker.token,
      }
      @requester.put linker.short, data
      linker.set_destination destination
      linker
    end

    # Delete a certain `Linker`
    def delete(linker : Linker) : Linker
      raise("Unauthorized: The token is missing") if !linker.original?

      data = {
        "token" => linker.token,
      }
      @requester.delete linker.short, data
      linker.short = ""
      linker
    end
  end
end
