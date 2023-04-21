"""
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a2 + b2 = c2
For example, 32 + 42 = 9 + 16 = 25 = 52.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc."""
import itertools
import math


def p9_bf(abc_sum):
  loop_count = 0
  product = 0
  for a, b in itertools.permutations(range(1, abc_sum), 2):
    c = math.sqrt(a**2 + b**2)
    sum = a + b + c
    if (a + b + c) == abc_sum:
      product = a * b * c
      break
    loop_count += 1

  print(f'{loop_count} loops counted')
  return product


abc_sum = 1000
solution = p9_bf(abc_sum)
print(solution)

# Let's see if we can do something different.
# How do we solve for pythagorean triples?
#
