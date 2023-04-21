import random


class Brutish:

  def __init__(self, good_count, bad_count, guesses):
    print('init')
    self.good_count = good_count
    self.bad_count = bad_count
    self.guesses = guesses
    self.gen_batt_config()
    self.get_test_path()

  def gen_batt_config(self):
    all_arrays = set()
    array = [0]*self.bad_count + [1]*self.good_count
    repeat_count = (self.bad_count + self.good_count)**4
    for _ in range(1, repeat_count):
      new_array = random.sample(array, len(array))
      all_arrays.add(tuple(new_array))

    self.all_configs = all_arrays

  def get_test_path(self):
    """
Generate all g sequences of pairs from b batteries.
Check that we get a success by g guesses for every pair.
    """
    attempts = 100000
    min_configs_size = len(self.all_configs)
    min_config = set()
    digits = range(0, self.good_count + self.bad_count)
    for _ in range(0, attempts):
      configs = self.all_configs.copy()
      guesses = []
      for _ in range(0, self.guesses):
        # print("size of configs", len(configs))
        guess = random.sample(digits, 2)
        guesses.append(guess)
        for config in configs.copy():
          turns_on = self.test(config[guess[0]], config[guess[1]])
          if turns_on:
            configs.remove(config)
        if len(configs) < min_configs_size:
          print(guesses)
          print(configs)
          min_configs_size = min(min_configs_size, len(configs))
      if len(configs) == 0:
        print('found it')
        print(guesses)
        return
    print("min config size", min_configs_size)

  def test(self, b1, b2):
    return b1 and b2


brute = Brutish(4, 4, 6)


# save a number of batteries
# a number of good and bad batteries
"""
Generate all the possible ways to test the batteries
Generate all the possible ways to set the good and bad batteries
Test all possiberl ways to test against all possible configurations
Check if ther eis a test method that allows to "win" in every config.
"""
