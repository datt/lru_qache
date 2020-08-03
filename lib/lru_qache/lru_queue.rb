class LRUQueue # Maintains a fixed size queue with unique keys
  attr_reader :max_size, :last_popped
  attr_accessor :queue
  ARG_ERROR = 'ArgError:: Passing Max Size is mandatory and must be a number' \
                 .freeze

  # @param max_size [Integer] Takes a number as an input, for queue size
  def initialize(max_size)
    raise ARG_ERROR if max_size.nil? || !max_size.is_a?(Integer)
    @max_size = max_size
    @queue = []
    @last_popped = nil
  end

  # removes last item from the queue
  def pop
    @last_popped = queue.pop
  end

  # Pushes item in the queue based on some conditions
  # 1. If item is repeated it pushed at first, removes duplicate
  # 2. If full, remove least used item i.e. last item and push
  # @param item [Object] takes any object and pushes in queue
  def push(item)
    queue.delete(item) if queue.include?(item) # deletes the key if present
    pop if full? # delete last item if queue is full
    queue.unshift(item) # insert at the start
  end

  # tells whether the queue is full or not
  def full?
    max_size == queue.size
  end
end
