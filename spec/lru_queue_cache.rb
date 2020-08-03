require './lib/lru_queue_cache'

describe LRUQueueCache, 'get' do
  context 'if value is present' do
    it 'returns the value which was set for a key' do
      lru_cache = LRUQueueCache.new(2)
      lru_cache.set('a', 11)
      lru_cache.set('b', 12)
      expect(lru_cache.get('a')).to eq(11)
    end
  end

  context 'if value is not present' do
    it 'returns -1' do
      lru_cache = LRUQueueCache.new(2)
      lru_cache.set('a', 11)
      expect(lru_cache.get('x')).to eq(-1)
    end
  end

  context 'if value is present, access with alias i.e. []' do
    it 'returns the value which was set for a key' do
      lru_cache = LRUQueueCache.new(2)
      lru_cache.set('a', 11)
      expect(lru_cache['x']).to eq(-1)
    end
  end

  context 'if no value is present' do
    it 'returns unique elements with less size' do
      lru_cache = LRUQueueCache.new(2)
      expect(lru_cache.get('x')).to eq(-1)
    end
  end
end

describe LRUQueueCache, 'set' do
  context 'If key is not present and cache capacity is available' do
    it 'removes last item' do
      lru_cache = LRUQueueCache.new(2)
      val = lru_cache.set('a', 11)
      expect(val).to eq(11)
    end
  end

  context 'If key is present' do
    it 'removes last item' do
      lru_cache = LRUQueueCache.new(2)
      val = lru_cache['a'] = 11
      expect(val).to eq(11)
    end
  end

  context 'Cache capacity is full and access old key' do
    it 'removes least used key' do
      lru_cache = LRUQueueCache.new(2)
      lru_cache.set('a', 11)
      lru_cache.set('b', 12)
      lru_cache.set('c', 13)
      expect(lru_cache.get('a')).to eq(-1)
    end
  end

  context 'If key is already present' do
    it 'replaces the value' do
      lru_cache = LRUQueueCache.new(2)
      lru_cache.set('a', 11)
      val = lru_cache.set('a', 12)
      expect(val).to eq(12)
    end
  end
end
