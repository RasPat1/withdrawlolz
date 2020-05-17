class Coins
  def initialize
    @memo = {}
  end

  def call(denoms, amount)
    # Denoms never changes so we can check this once on class
    # initialization for perf rather than on each recursive call
    return nil if invalid_denoms?(denoms)
    return nil if invalid_amount?(amount)

    return init_counts(denoms) if amount == 0
    return @memo[amount] if @memo.key?(amount)

    # Since we disallow zero denomination coins the most coins
    # possible to create an amount is amount/1 aka amount
    # So let's max our min count at amount/1 + 1 to cover all cases
    min_count = amount + 1
    min_solution = nil

    denoms.each do |denom|
      # Clone to avoid messing up values already in the cache (ruby passes by reference for hashes)
      candidate_solution = call(denoms, amount - denom).clone
      next if candidate_solution == nil

      # We've returned a valid candidate so let's add the coin we used to generate the subamount
      # and check if this candidate uses fewer coind than our best solution so far

      candidate_solution[denom] += 1
      coin_count = Util.coin_count(candidate_solution)

      if coin_count < min_count
        min_solution = candidate_solution
        min_count = coin_count
      end
    end

    @memo[amount] = min_solution
    return @memo[amount]
  end

  # This could be generated once on class initialization
  def init_counts(denoms)
    counts = {}

    denoms.each do |denom|
      counts[denom] = 0
    end

    counts
  end

  def invalid_denoms?(denoms)
    denoms == nil || denoms.size <= 0 || denoms.any? { |num| invalid?(num) }
  end

  def invalid_amount?(amount)
    return false if amount == 0
    invalid?(amount)
  end

  def invalid?(num)
    num == nil || num <= 0 || num % 1 != 0
  end
end

class Util
  def self.coin_count(count_hash)
    count_hash.values.sum
  end

  def self.coin_sum(count_hash)
    sum = 0

    count_hash.each do |denom, count|
      sum += denom * count
    end

    sum
  end
end

class Test
  attr_accessor :denoms, :amount, :expected

  def initialize(denoms, amount, expected)
    @denoms = denoms
    @amount = amount
    @expected = expected
  end

  # What about when there are multiple ways to make change?
  # Then we want the least.
  # What if there are multiple ways to make change with the same number of coins?
  # Then we're okay with any of them.
  # Let's say a solution is valid if and only if it:
  # 1) adds up to the correct amount,
  # 2) uses only the given denominations
  # 3) uses exactly the specified number of coins
  # This handles the multiple solutions case and makes it easier to specify a
  # test solution by simply providing the minimum coin count. We know if our solution
  # solves the problem in fewer than the specified coin count our test is wrong so we want
  # to fail in that case as well.
  def valid_solution?(proposed_solution)
    return true if expected == proposed_solution

    return false unless proposed_solution.all? { |denom| denoms.include?(denom) }
    return false unless Util.coin_sum(proposed_solution) == amount
    return false unless expected_coin_count = Util.coin_count(proposed_solution)
  end

  def to_s
    "Denoms: #{@denoms}, Amount: #{@amount}, Expected: #{@expected}"
  end
end

class TestExec
  # Setup some shared vars
  def initialize
    @d1            =   [25, 10, 5, 1]
    @d1_rev        =   [1, 5, 10, 25]
    @d1_rand       =   [10, 1, 25, 5]
    @d2            =   [3, 10, 17]
    @d0            =   [0]
    @d_nil         =   nil
    @d_empty       =   []
    @d_invalid_1   =   [1, 10, nil, 25]
    @d_invalid_2   =   [0, nil]
    @d_invalid_3   =   [5, 10, -20]
    @d_invalid_4   =   [0, 10, -20]
    @d_invalid_5   =   [0, 10, 20]
    @d_invalid_6   =   [2, 5, 10.8, 25]
  end

  def call
    run(valid_tests)
    run(invalid_tests)
  end

  def valid_tests
    [
      Test.new(@d1,          0,      0  ),    # {25 => 0,   10 => 0, 5 => 0, 1 => 0}
      Test.new(@d1,          28,     4  ),    # {25 => 1,   10 => 0, 5 => 0, 1 => 3}
      Test.new(@d1_rev,      28,     4  ),    # {25 => 1,   10 => 0, 5 => 0, 1 => 3}
      Test.new(@d1_rand,     28,     4  ),    # {25 => 1,   10 => 0, 5 => 0, 1 => 3}
      Test.new(@d1,          278,    14 ),    # {25 => 11,  10 => 0, 5 => 0, 1 => 3}
      Test.new(@d1_rev,      278,    14 ),    # {25 => 11,  10 => 0, 5 => 0, 1 => 3}
      Test.new(@d1_rand,     278,    14 ),    # {25 => 11,  10 => 0, 5 => 0, 1 => 3}
      Test.new(@d2,          278,    18 ),    # {17 => 16,  10 => 0, 3 => 2        }
      Test.new(@d2,          78,     5  ),    # {17 => 4,   10 => 1, 3 => 0        }
    ]
  end

  # Amount can not be made from denominations
  # Amount is too small
  # Amount cannot be broken down into coins
  # Negative amounts
  # fractional amounts
  # nil amount
  # denominations are negative, fractional, or nil
  def invalid_tests
    [
      Test.new(@d1,          nil,    nil),
      Test.new(@d1,          -50,    nil),
      Test.new(@d1,          10.8,   nil),
      Test.new(@d2,          1,      nil),
      Test.new(@d0,          0,      nil),
      Test.new(@d0,          100,    nil),
      Test.new(@d_nil,       0,      nil),
      Test.new(@d_nil,       100,    nil),
      Test.new(@d_empty,     0,      nil),
      Test.new(@d_empty,     100,    nil),
      Test.new(@d_invalid_1, 100,    nil),
      Test.new(@d_invalid_2, 100,    nil),
      Test.new(@d_invalid_3, 100,    nil),
      Test.new(@d_invalid_4, 100,    nil),
      Test.new(@d_invalid_5, 100,    nil),
      Test.new(@d_invalid_6, 100,    nil),
    ]
  end

  def run(tests)
    tests.each do |test|
      result = Coins.new.call(test.denoms, test.amount)

      unless test.valid_solution?(result)
        puts "Test Failed! Result: #{result} -- #{test}"
      end
    end
  end
end

TestExec.new.call