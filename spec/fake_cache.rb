class FakeCache
  attr_accessor :store
  
  def initialize
    self.store = {}
  end
  
  def read(key)
    store[key]
  end

  def write(key, value, options = {})
    store[key] = value
  end

end
