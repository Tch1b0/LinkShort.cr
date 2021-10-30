# linkshort
A crystal wrapper for the LinkShort API

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     linkshort:
       github: Tch1b0/LinkShort.cr
       branch: master
   ```

2. Run `shards install`

## Usage

```crystal
require "linkshort"
```

Create a new `LinkShort` instance
```crystal
linkshort = LinkShort::LinkShort.new
```

Create a new `Linker`
```
linker = linkshort.create "the-link-i-want-to-shorten.com"
```

## Contributing

1. Fork it (<https://github.com/Tch1b0/LinkShort.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tch1b0](https://github.com/your-github-user) - creator and maintainer
