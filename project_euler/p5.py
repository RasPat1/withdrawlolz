"""2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?"""

# As far as I understand this just needs the same prime factorization with no extra terms of the numbers between 1-20.
# Since any non-primes will be products of the primes between 1-20 anyways and so will be evenly divisible. We just need to make sure we have the smallest number of factors since we're looking for the smallest number.
# To be divisible by 9 it shoule be divisible by 3 twice, to be divisble by 6 we can do 3 * 2 for 8 we can do 2 and 4.

import functools
import operator


# Oops. this isn't very readable....
def p5(max):
  sieve = [x for x in range(1, max + 1)]
  for factor in range(2, len(sieve)):
    index = 2 * factor - 1
    remaining_factors = sieve[factor - 1]
    while index < len(sieve):
      sieve[index] //= remaining_factors
      index += factor
    # print(sieve)
  return functools.reduce(operator.mul, sieve)


max = 200_000_0
solution = p5(max)
# print(solution)


"""There is a v cool solution for this that is more interesting.
The largest number of factors for each prime you will have wil be determined by the largest perfect prime powers.
So for max = 20 the largest power of 2 is 16 or 2^4 so we know we need 4 factors of 2 and the largest factor of 3 is 3^2 or 9.
and so for a max up to n just multiply all the primes with each prime having the exponent log(n)/ log(prime). You only need to go up to sqrt n as well. So that really is easy mode.
"""
