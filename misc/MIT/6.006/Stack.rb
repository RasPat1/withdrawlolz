# Stack Implementation
class Stack
  def initialize
    @data = []
    @size = 0
  end

  def pop
    @data[@data.size - 1]
  end

  def push(item)
    @size += 1
  end

  def peek
    @data[@data.size - 1]
  end

  def isEmpty
    @size == 0
  end
end