import math


def p7(nth_prime):
  prime_count = 1
  num = 2
  while prime_count < nth_prime:
    num += 1
    if is_prime(num):
      prime_count += 1

  return num


def is_prime(n):
  sqrt = int(math.sqrt(n))
  for divisor in range(2, sqrt + 1):
    if n % divisor == 0:
      return False
  return True


def p7_sieve(nth_prime):
  # For a sieve of erasthones how do you decide how large to initialize the array to?
  # There was that equation iwth the golden ration in it wasn't there?
  # We can use the prime counting function here. There is a proof and it is complicated.
  # Our question. What is a close upper bound on the nth prime?
  # it looks like we can get reasonably close with n * ln(n) for our case of n = 10_001
  # this comes out to 92_113. Let's add some reasonable buffer.
  # Still some inefficiencies and a few clunky spots but should do fine

  buffer_size = 1.5
  estimated_prime_size = nth_prime * math.log(nth_prime)

  # Adds a buffer since the estimate from the prime counting theorem is rough.
  sieve_size = int(estimated_prime_size * buffer_size)

  # Adds 1 as a buffer on the left side of the array.
  # This let's us avoid some off-by-one munging and 1 is not a prime.
  sieve = [False, False] + [True] * sieve_size
  max_factors = int(math.sqrt(sieve_size)) + 2

  for factor in range(2, max_factors + 1):
    # If it's marked false we've already marked all of it's possible multiples.
    if not sieve[factor]:
      continue

    # Visit all indicies of all multiples of this factor
    multiple = factor * 2
    while multiple < len(sieve):
      sieve[multiple] = False
      multiple += factor

  # Get the nth true value from the sieve.
  primes = [index for index,
            is_prime in enumerate(sieve) if is_prime]
  return primes[nth_prime - 1]


# prime = p7(10_001)
prime = p7_sieve(10_001)
print(prime)
