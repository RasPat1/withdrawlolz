require 'byebug'

class KeyStore
  def initialize
    @data = {}
    @all_transactions = []
  end

  def set(key, value)
    record_op(key, @data[key])
    @data[key] = value
  end

  def unset(key)
    record_op(key, @data[key])
    @data[key] = nil
  end

  def get(key)
    @data[key]
  end

  # When we run begin create a new transaction
  def begin
    new_transaction = Transaction.new(@data)

    # Record nested transactions in teh parent transactions buffer
    if current_transaction
     current_transaction.add_nested_transaction(new_transaction)
   end

   @all_transactions << new_transaction
  end

  # When we run rollback end the currently open transaction
  # and rollback its operations
  def rollback
    current_transaction.rollback
    last_transaction = @all_transactions.pop
  end

  def commit
    current_transaction.commit
    transaction = @all_transactions.pop
  end

  def record_op(key, prev_value)
    if current_transaction
      current_transaction.add_reverse_op(key, prev_value)
    end
  end

  def current_transaction
    @all_transactions.last
  end
end

class Transaction
  def initialize(data)
    @buffer = []
    # all transactinos are pointing to the same data
    @data = data
  end

  def add_reverse_op(key, value)
    @buffer << Operation.new(key, value)
  end

  def commit
    # Do nothing in this implementation
  end

  def rollback
    @buffer.reverse.each do |op|

      if op.kind_of?(Transaction)
        op.rollback
      elsif op.kind_of?(Operation)
        @data[op.key] = op.value
      end
    end
  end

  def add_nested_transaction(transaction)
    @buffer << transaction
  end
end

class Operation
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

### Just for the Lulz...
class KeyStoreTester
  CHARS = ('a'..'z').to_a
  MAX_DATA = 10 ** 10

  def perf_test
    ks = KeyStore.new
    puts "Testing Performance"
    time_taken = 0
    control_time = 0
    ks = KeyStore.new

    func = Proc.new do |k, v|
      ks.set(k, v)
      ks.get(k)
    end

    func_with_unset = Proc.new do |k, v|
      ks.set(k, v)
      ks.get(k)
      ks.unset(k)
    end

    control_input = Proc.new do |k,v|
    end


    experiment_time = 0
    experiment_input_1 = Proc.new do |k,v|
      ks.set('x', 100)
      ks.get('x')
    end
    experiment_input_2 = Proc.new do |k,v|
      ks.set('x', 100)
      ks.get('x')
      ks.unset('x')
    end

    iteration_count = 1000000
    iteration_count.times do |val|
      coin_flip_result = coin_flip
      input = coin_flip_result ? func : func_with_unset
      experiment_input = coin_flip_result ? experiment_input_1 : experiment_input_2

      time_taken += record_work(input, rand_key, rand_data)
      control_time += record_work(control_input, rand_key, rand_data)
      experiment_time += record_work(experiment_input, rand_key, rand_data)
    end

    normalized_time = time_taken - control_time
    experiment_normalized_time = experiment_time - control_time
    puts "Control Time: #{control_time}ms"

    puts "#{iteration_count} executions for Main test took: #{normalized_time}ms"
    puts "#{iteration_count} executions for flat data took: #{experiment_normalized_time}ms"
  end

  def rand_key
    max_length = 31
    alphabet_len = 26
    len = (rand * max_length).ceil
    string = []
    len.times do
      rand_char_index = (rand * max_length).floor
      string << CHARS[rand_char_index]
    end

    string.join
  end

  def rand_data
    (rand * MAX_DATA).floor
  end

  def coin_flip
    rand < 0.5
  end

  def record_work(func, key, val)
    start = Time.now
    func.call(key, val)
    stop = Time.now

    stop - start
  end
  def test
    test_basics
    test_transaction_commit
    test_transaction_rollback
    test_transaction_rollback_2
    test_nested_transaction
    test_triple_nested
  end

  def test_basics
    ks = KeyStore.new
    puts "Testing Basics"
    assert(ks.get('k1'), nil)
    assert(ks.unset('k1'), nil)
    assert(ks.get('k1'), nil)
    assert(ks.set('k1', 1), 1)
    assert(ks.get('k1'), 1)
    assert(ks.set('k1', 2), 2)
    assert(ks.get('k1'), 2)
    assert(ks.unset('k1'), nil)
    assert(ks.get('k1'), nil)
  end

  def test_transaction_commit
    ks = KeyStore.new
    puts "Testing Transaction: Basic Commits"
    assert(ks.set('k1', 1), 1)
    ks.begin
    assert(ks.get('k1'), 1)
    assert(ks.unset('k1'), nil)
    assert(ks.get('k1'), nil)
    ks.commit
    assert(ks.get('k1'), nil)
  end

  def test_transaction_rollback
    ks = KeyStore.new
    puts "Testing Transaction: Basic Rollback"
    assert(ks.set('k1', 1), 1)
    ks.begin
    assert(ks.get('k1'), 1)
    assert(ks.unset('k1'), nil)
    assert(ks.get('k1'), nil)
    ks.rollback
    assert(ks.get('k1'), 1)
  end

  def test_transaction_rollback_2
    ks = KeyStore.new
    puts "Testing Transaction: Basic Rollback 2"
    assert(ks.get('k1'), nil)
    ks.begin
    assert(ks.get('k1'), nil)
    assert(ks.set('k1', 1), 1)
    assert(ks.get('k1'), 1)
    ks.rollback
    assert(ks.get('k1'), nil)
  end

  def test_nested_transaction
    var_name = 'k1'
    puts "Test Nested Transactions"
    ks = KeyStore.new

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.commit
    ks.set('k1', 4)
    ks.commit
    assert(ks.get('k1'), 4)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.rollback
    ks.set('k1', 4)
    ks.commit
    assert(ks.get('k1'), 4)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.commit
    ks.set('k1', 4)
    ks.rollback
    assert(ks.get('k1'), 1)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.rollback
    ks.set('k1', 4)
    ks.rollback
    assert(ks.get('k1'), 1)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.rollback
    ks.rollback
    assert(ks.get('k1'), 1)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.commit
    ks.rollback
    assert(ks.get('k1'), 1)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.commit
    ks.commit
    assert(ks.get('k1'), 3)

    ks.set('k1', 1)
    ks.begin
    ks.set('k1', 2)
      ks.begin
      ks.set('k1', 3)
      ks.rollback
    ks.commit
    assert(ks.get('k1'), 2)
  end

  def test_triple_nested
    ks = KeyStore.new
    ks.begin
      ks.begin
        ks.set('k1', 1)
        ks.begin
          ks.set('k2', 2)
          ks.begin
            ks.set('k3', 3)
            ks.set('k3', 30)
            ks.set('k2', 20)
            ks.set('k1', 10)
          ks.commit
          ks.set('k1', 100)
          ks.set('k1', 200)
          ks.set('k3', 300)
        ks.rollback
      ks.commit
    ks.commit


    assert(ks.get('k1'), 1)
    assert(ks.get('k2'), nil)
    assert(ks.get('k3'), nil)
  end

  def assert(result, expected_output)
    if result == expected_output
      puts "Test Passed"
    else
      puts "Test Failed: result: #{result} did not equal #{expected_output} "
    end
  end
end

KeyStoreTester.new.test
KeyStoreTester.new.perf_test