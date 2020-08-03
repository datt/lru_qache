# LRUQueueCache

The LRU(least recently used) caching scheme is to remove the least recently used item when the cache reaches it's defined capacity. This gem implements this cache using a simple customised implementation of queue.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lru_queue_cache'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lru_queue_cache

## Usage
```ruby
require "lru_cache"

# create a new cache with a 100 items capacity.
cache = LRUQueueCache.new(100)

# set an item in cache
cache.set('key', 'your_value')

cache.get('key')
# returns 'your_value'

```

### Documentation

`YARD` is used for generating documentation
Generate documentation using yardoc `lib/**/*.rb` and open doc/index.html in browser.


### Test
To run the test cases

`rspec spec/*`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/datt/lru_queue_cache.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
