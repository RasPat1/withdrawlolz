# Implementation of a HEAP!
class Heap
  def initialize(data = [])
    @data = data
  end

  def size
    @data.size
  end

  # Take in an array and create a heap out of it
  def self.build(input)
    heap = Heap.new(input)

    start = heap.size / 2
    start.downto(0) do |index|
      heap.heapify(index)
    end

    heap
  end

  def get(key)
    @data[key]
  end

  def add(value)
    update_value(size, value)
  end

  # returns value of max
  def max
    @data[0]
  end

  def extract_max(key = 0)
    value = @data[key]
    return nil if value == nil

    @data[key] = extract_max(larger_child(key))
    value
  end

  def update_value(key, new_value)
    @data[key] = new_value

    while key != nil
      heapify(key)
      key = Heap.parent(key)
    end
  end

  # Main assumption is that left and right children of key
  # mintain the heap invariant
  def heapify(key = 0)
    # Assume left and right children follow heap property
    value = get(key)
    return if value == nil

    larger_child_key = larger_child(key)
    larger_value = get(larger_child_key)

    if larger_value != nil && larger_value > value
      @data[key] = @data[larger_child_key]
      @data[larger_child_key] = key
      heapify(larger_child_key)
    end
  end

  def self.left_child(key)
    (2 * key) + 1
  end

  def self.right_child(key)
    2 * (key + 1)
  end

  def self.parent(key)
    return nil if key == 0
    (key - 1) / 2
  end

  def larger_child(key)
    left_key = Heap.left_child(key)
    right_key = Heap.right_child(key)

    return left_key if @data[right_key] == nil
    return right_key if @data[left_key] == nil

    @data[left_key] > @data[right_key] ? left_key : right_key
  end

  def to_s
    @data.join(',')
  end
end