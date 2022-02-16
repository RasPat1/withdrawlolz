"""The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
"""
import math


def p3(num):
  possible_factor = 2
  largest_factor = 1
  sqrt_num = math.sqrt(num)

  while possible_factor <= num:
    while num % possible_factor == 0:
      if possible_factor > largest_factor:
        largest_factor = possible_factor
      num = num / possible_factor
    possible_factor += 1

    # If our num is larger than the sqrt it's prime.
    # That prime is the largest factor. No need to keep
    # counting. Jut bounce out of the loop and return that.
    if possible_factor > sqrt_num:
      print('skip')
      largest_factor = possible_factor
      break
  return largest_factor


number = 600851475143
test_skip_behavior_num = 103
solution = p3(number)
print(solution)
