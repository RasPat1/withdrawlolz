# Find the smallest number such that subtracting amsuccessively increasing fractino of the total always yields a whole
# number....
# In other words. Imagine there are k pirates. Each one takes a share of the remaining treasure in the chest. The first
# takes 1/k. the second 2/k of the remaining treasure. the third 3/k of what remains after pirates 1 and 2 have gone all
# the way until pirate k who takes k/k or all of the remaining treasure.
# What is the minimum number of coins necessary for each pirate to have a whole number of coins.
#

def split_gold(k, debug_mode)
  max = 10 ** 9
  min = 1
  min = 35831808
  # min = 71663616
  min.upto(max) do |gold|
    puts "Trying #{gold} coins in chest" if debug_mode
    chest = gold
    1.upto(k) do |pirate|
      puts "Pirate: #{pirate}" if debug_mode
      puts "Chest Size: #{chest}" if debug_mode
      puts "Mod result: #{(pirate * chest) % k}" if debug_mode
      puts "K Value: #{k}" if debug_mode
      break if (pirate * chest) % k != 0
      puts "evenly divisible" if debug_mode
      share = pirate * chest / k
      puts "Share size for pirate #{pirate}: #{share}" if debug_mode
      chest -= share
    end
    return gold if chest == 0
  end

  return 'fail'
end

k = 10

puts split_gold(k, true)
