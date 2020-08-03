require './lib/lru_qache/lru_queue'

describe LRUQueue, 'push' do
  context 'if size is 1, keep only latest 1 item' do
    it 'returns one recently pushed item' do
      lru_queue = LRUQueue.new(1)
      lru_queue.push('a')
      lru_queue.push('b')
      expect(lru_queue.queue).to eq(['b'])
    end
  end

  context 'if size is n, keeps only latest n items' do
    it 'returns one recently 3 pushed items' do
      lru_queue = LRUQueue.new(3)
      lru_queue.push('a')
      lru_queue.push('b')
      lru_queue.push('c')
      lru_queue.push('d')
      expect(lru_queue.queue).to eq(['d','c', 'b'])
    end
  end

  context 'Shifts the element at first if repeated' do
    it 'returns unique elements with less size' do
      lru_queue = LRUQueue.new(3)
      lru_queue.push('a')
      lru_queue.push('b')
      lru_queue.push('a')
      expect(lru_queue.queue).to eq(['a', 'b'])
    end
  end
end

describe LRUQueue, 'pop' do
  context 'if size is n, keep only latest 1 item' do
    it 'removes last item' do
      lru_queue = LRUQueue.new(2)
      lru_queue.push('a')
      lru_queue.push('b')
      lru_queue.pop
      expect(lru_queue.queue).to eq(['b'])
    end
  end

  context 'if size is 0' do
    it 'returns nil' do
      lru_queue = LRUQueue.new(3)
      expect(lru_queue.pop).to eq(nil)
    end
  end
end

describe LRUQueue, 'full?' do
  context 'if size is n and all filled' do
    it 'returns true' do
      lru_queue = LRUQueue.new(2)
      lru_queue.push('a')
      lru_queue.push('b')

      expect(lru_queue.full?).to eq(true)
    end
  end

  context 'if size is n and all not filled' do
    it 'returns false' do
      lru_queue = LRUQueue.new(3)
      lru_queue.push('a')
      expect(lru_queue.full?).to eq(false)
    end
  end
end