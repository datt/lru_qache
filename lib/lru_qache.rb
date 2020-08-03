# require "lru_qache/lru_queue"
class LruQache # LRU cache is caching technique based on recently used data.
  MAX_CAPACITY = 5
  DEFAULT_VAL = -1

  InvalidCapacityError = Class.new RuntimeError
  INVALID_CAPACITY = 'Capacity must be valid number'.freeze

  attr_reader :options, :cache, :capacity

  # @param capacity [Integer] Takes a number as an input and
  # @param options [Hash] optional hash for some settings like custom value if \
  # key is not present
  # @option options [Integer] :default_val
  def initialize(capacity = MAX_CAPACITY, options = { default_val: DEFAULT_VAL })
    raise InvalidLimitError, INVALID_CAPACITY unless capacity.is_a?(Integer)
    @cache = {}
    @options = options
    @capacity = capacity
  end

  # This gets the value based on the key is provided, updates the key usage
  #
  # @param key input parameter
  # @return value [Object] if key is present
  # @example get(x)
  def get(key)
    value = retrieve(key)
    update_lru(key) unless value == options[:default_val]
    value
  end

  # Sets the value of cache's key
  #
  # @param key any valid object
  # @param key any valid object
  # @example set('a', 1)
  # @todo Add validation to the key e.g. only Symbol, String or Integer etc.
  def set(key, val)
    @cache.delete(key)
    @cache[key] = val
    remove_lru_if_needed
    val
  end

  alias [] get
  alias []= set

  private
  # This is used for not modifying the 'last_used' key when using internal logic
  #
  # @param key input parameter
  # @return value [Object] if key is present
  def retrieve(key)
    cache.fetch(key) { options[:default_val] }
  end

  # This removes the least recently used key from cache and also updates queue
  #
  # @param key input parameter
  def remove_lru_if_needed
    # update the queue with new key
    # remove LRU key if capacity is full.
    cache.shift if cache.size > capacity
  end

  # Updates the lru with the key, removes key and sets again so key goes
  # to the last
  #
  # @param Takes key the input, it can be any valid Object needed for hash
  def update_lru(key)
    val = cache.delete(key)
    cache[key] = val
  end
end