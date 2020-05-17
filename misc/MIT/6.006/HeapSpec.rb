require './Heap.rb'
require 'byebug'

# Reference spec for a heap implmentation
class HeapSpec
  def test
    puts "key_movement_checker START"
    key_movement_checker
    puts "key_movement_checker END"
    puts "reads_max START"
    reads_max
    puts "reads_max END"
    puts "extracts_max START"
    extracts_max
    puts "extracts_max END"
    puts "updates_value START"
    updates_value
    puts "updates_value END"
    puts "follows_invariant START"
    follows_invariant(random_heap(3))
    puts "follows_invariant END"
    puts "creates_valid_heap START"
    creates_valid_heap([1,2,3,4,5])
    puts "creates_valid_heap END"
  end

  def key_movement_checker
    assert Heap.left_child(0) == 1
    assert Heap.right_child(0) == 2
    assert Heap.left_child(1) == 3
    assert Heap.right_child(1) == 4
    assert Heap.left_child(2) == 5
    assert Heap.right_child(2) == 6
    assert Heap.parent(0) == nil
    assert Heap.parent(1) == 0
    assert Heap.parent(2) == 0
    assert Heap.parent(3) == 1
    assert Heap.parent(4) == 1
    assert Heap.parent(5) == 2
    assert Heap.parent(6) == 2
  end

  def follows_invariant(heap, key = 0)
    max_value = heap.get(key)
    test_invariant(heap, max_value, Heap.left_child(key))
    test_invariant(heap, max_value, Heap.right_child(key))
  end

  def test_invariant(heap, max_value, key)
    value = heap.get(key)
    return true if value == nil
    assert max_value >= value
    assert follows_invariant(heap, key)
  end

  def creates_valid_heap(input)
    heap = Heap.build(input)
    follows_invariant(heap)
  end

  def reads_max
    heap = Heap.build([1,2,4,3,6,2,4])
    assert heap.max == 6
    # Ensure the max node was not taken out of the heap
    assert heap.max == 6
  end

  def extracts_max
    # debugger
    heap = Heap.build([1,2,4,3,6,2,4])
    max_value = heap.extract_max
    assert max_value == 6
    # make sure we popped the previous max out
    assert heap.max == 4
    follows_invariant(heap)
  end

  # This updates teh key and re-heapifies
  # Do we need a new
  def updates_value
    heap = Heap.build([1,2,3,4,5,6,7])
    leftmost_key = 0

    while heap.get(leftmost_key) != nil
      leftmost_key = Heap.left_child(leftmost_key)
    end

    # Go to nil and then walk back up one
    leftmost_key = Heap.parent(leftmost_key)

    # Create a new max here and ensure that the node is now at the top
    new_max_value = heap.max + 1

    # Is this the right interface
    # Todo: Check and maybe fix this
    heap.update_value(leftmost_key, new_max_value)
    assert heap.max == new_max_value
    follows_invariant(heap)
  end

  # Get a random heap
  # Todo: Make this random
  def random_heap(size)
    heap = Heap.new()
    heap.add(1)
    heap.add(4)
    heap.add(5)

    follows_invariant(heap)

    heap
  end

  # def greater(max, value_or_nil)
  #   value_or_nil == nil || max >= value_or_nil
  # end

  def assert(expectation)
    if expectation
      # puts "Test Passed"
      true
    else
      puts "   Test Failed"
      false
    end
  end
end

HeapSpec.new.test