"""
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million."""


def p10(prime_limit):
  sieve = [1] * prime_limit
  prime_sum = 0

  for candidate_prime in range(2, prime_limit + 1):
    prime_index = candidate_prime - 1
    if sieve[prime_index] != 1:
      continue
    prime_sum += candidate_prime
    multiple_index = prime_index + candidate_prime
    while multiple_index < len(sieve):
      sieve[multiple_index] = 0
      multiple_index += candidate_prime

  return prime_sum


# prime_limit = 10
prime_limit = 2_000_000
solution = p10(prime_limit)
print(solution)
