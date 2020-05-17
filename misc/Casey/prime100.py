def primeList(x):
	for n in range(2, x):
		if is_prime(n) == True:
			print n

def is_prime(n):
	for i in range(2, n/2+1):
		if n % i == 0:
			return False
	return True

primeList(110)