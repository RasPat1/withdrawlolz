"""If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000."""


def p1():
  # We can just loop. Or if we want to be fancier we can add the series of 3's and 5's and subtract the 15's
  sum = 0
  for num in range(1, 999):
    if num % 3 == 0 or num % 5 == 0:
      sum += num

  return sum


def p1_alt():
  # If the number gets too big we dont' want to loop.
  # Add up all the nums diviisble by 3 and 5 and subtract the ones divisible by 15.
  # To add up all the numbers divisible by 3 or 5 or 15 consider it an arithmetic sequence.
  max = 999
  return sumDivisibleNumbers(3, max) + sumDivisibleNumbers(5, max) - sumDivisibleNumbers(15, max)


def sumDivisibleNumbers(divisble_by, max_num):
  # Ha this is sloppy. What if max_num is less than the divisible_by...
  # You're not even returning an int you nerd.

  number_of_terms = max_num // divisble_by
  first_term = divisble_by
  last_term = number_of_terms * divisble_by
  return number_of_terms * ((first_term + last_term) / 2)


if __name__ == '__main__':
  solution = p1_alt()
  print(solution)
