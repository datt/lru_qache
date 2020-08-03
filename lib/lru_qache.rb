require "lru_qache/lru_queue"

class LRUQache # LRU cache is caching technique based on recently used data.
  MAX_CAPACITY = 5
  DEFAULT_VAL = -1

  InvalidCapacityError = Class.new RuntimeError
  INVALID_CAPACITY = 'Capacity must be valid number'.freeze

  attr_reader :options, :cache

  # @param capacity [Integer] Takes a number as an input and
  # @param options [Hash] optional hash for some settings like custom value if \
  # key is not present
  # @option options [Integer] :default_val
  def initialize(capacity = MAX_CAPACITY, options = { default_val: DEFAULT_VAL })
    raise InvalidLimitError, INVALID_CAPACITY unless capacity.is_a?(Integer)
    @cache = {}
    @options = options
    @lru_queue = LRUQueue.new(capacity)
  end

  # This gets the value based on the key is provided, updates the key usage
  #
  # @param key input parameter
  # @return value [Object] if key is present
  # @example get(x)
  def get(key)
    return options[:default_val] if cache[key].nil?
    update_queue(key)
    retrieve(key)
  end

  # Sets the value of cache's key
  #
  # @param key any valid object
  # @param key any valid object
  # @example set('a', 1)

  # @todo Add validation to the key e.g. only Symbol, String or Integer etc.
  def set(key, val)
    remove_lru_if_needed(key)
    @cache[key] = val
  end

  alias [] get
  alias []= set

  private

  # Logic to handle whether to set a key, now it only checks if key present
  #
  # @param Takes key the input, it can be any valid Object needed for hash
  def need_to_set?(key)
    retrieve(key).nil?
  end

  # This is used for not modifying the 'last_used' key when using internal logic
  #
  # @param key input parameter
  # @return value [Object] if key is present
  def retrieve(key)
    cache[key]
  end

  # This removes the least recently used key from cache and also updates queue
  #
  # @param key input parameter
  def remove_lru_if_needed(key)
    update_queue(key)  # update the queue with new key
    @cache.delete(@lru_queue.last_popped) if @lru_queue.full?
    # remove LRU key if capacity is full.
  end

  # Updates the queue with the key
  #
  # @param Takes key the input, it can be any valid Object needed for hash
  def update_queue(key)
    @lru_queue.push(key)
  end
end