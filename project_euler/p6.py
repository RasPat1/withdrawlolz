"""The sum of the squares of the first ten natural numbers is,
1^2 + 2^2 + ... + 10^2 = 385

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... 10)^2 = 55^2 = 3025

Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is
3025 - 385 = 2640

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum."""
import functools
import operator


def p6(max):
  # Brute force
  num_range = range(1, max + 1)
  sum_of_squares = functools.reduce(
      operator.add, map(lambda x: x**2, num_range))
  square_of_sums = functools.reduce(operator.add, num_range) ** 2

  return square_of_sums - sum_of_squares


"""
We can use some algebra to simplify this I think.

(a + b + c)^2 = a^2 + b^2 + c^2 + 2ab + 2bc + 2ac

(a + b + ... n)^2 = a^2 + b^2 + ... + n^2 + 2(ab + ... an + bc + ... + bn + mn)
all pairwise combinations.
And since we are subtracting the sum of the squares aka a^2 + b^2 + ... n^2 the result is
2(ab + ac + .. an + bc +...)
If we know that we are using a sequence of natural numbers we can simplify this....
firt we can say forget gropuing the terms and stick with ab and ba being separate.
it's a * (b + ... n) + b * (a + c + ... n) or if we call a + b +... +n = S then
a * (S - a) + b * (S - b)...
Since S = a + n / 2 * n this is easy
in fact... this simplflies again.
S(a + b + ... n) - (a^2 + b^2 + n...)
but since (a + b + ... n) is S we have S^2 - our original value the sum of the squares
So this would be
sum of natural numbers up to N squared - Sum of the squares.
Too bad we have to compute the sum of the square at all though...

"""


def p6_math(max):
  num_range = range(1, max + 1)
  sum_of_natural_numbers = (1 + max) * max // 2
  sum_of_squares = functools.reduce(
      operator.add, map(lambda x: x**2, num_range))
  return sum_of_natural_numbers ** 2 - sum_of_squares
# yay! it works!
# I would love to not have to calculate teh sum of the squares at all though...
# Hmm somethign is fishy though. I wen too far i think... oh duh. Now that I look at it thsi si funny. I went into a mathematical circle and did literaly nothing. I just replaced my loop with the formula for the sum of the natural numbers lol catz. Wow I like thougth for one second I actually did math but actualy ended up doing nothing. Which is literally what I always do. Go in a circle and get confused.
# Let's go backwards. Oh! right th
# If I can find a formula for this value: 2(ab + ... an + bc + ... + bn + mn) I can construct a closed formula for the some of the squares
# for a...n -> ab + ac + ... + an + ba + bc + ... + bn + ca ...
# -> 2* [a*(b + ... + n) + b*(c + ... + n) + ...]


max = 100
# solution = p6(max) # 25164150
solution = p6_math(max)
print(solution)
