"""
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.
"""
import itertools


def p4():
  # Dumb brute force here is easy.
  largest_pdrome = 0
  loop_count = 0
  for n1, n2 in itertools.combinations(range(100, 1000), 2):
    product = n1 * n2
    if is_palindrome(product) and product > largest_pdrome:
      largest_pdrome = product
    loop_count += 1
  print(f'{loop_count} Loops looped for p4')
  return largest_pdrome


def is_palindrome(num):
  str_num = str(num)
  return str_num[::-1] == str_num


# What's a more interesting way?
# Firstly we're doing twice the work here since multiplication is commutative. Okay fixed that real quick. now what.
# Is there a way to loop through this such that we are goign in decreasing order of products?

def p4_cool():
  loop_count = 0
  largest_pdrome = 0
  for n1 in range(999, 99, -1):
    for n2 in range(999, n1 - 1, -1):
      loop_count += 1
      product = n1 * n2
      if product <= largest_pdrome:
        break
      if is_palindrome(product) and product > largest_pdrome:
        largest_pdrome = product
  print(f'{loop_count} Loops looped for p4cool')
  return largest_pdrome


"""This is fast but can be sped up further with some analysis. Consider the digits
of P – let them be x, y and z. P must be at least 6 digits long since the
palindrome 111111 = 143×777 – the product of two 3-digit integers. Since P is
palindromic:
P=100000x + 10000y + 1000z + 100z + 10y + x
P=100001x + 10010y + 1100z
P=11(9091x + 910y + 100z)

Ho freaking cool is that! They must be factors of 11 so you can use that to check fewer combinations.  If the first number is not divisible by 11 then decrease the second number by 11 at a time starting from 990.  Woof that's super clever.
"""


def p4_coolest():
  loop_count = 0
  largest_pdrome = 0
  for n1 in range(999, 99, -1):
    n2 = 999
    n2_delta = 1

    # n2 needs to be divisilbe by 11 so start at
    # 990 and subtract by 11 each time.
    if n1 % 11 != 0:
      n2 = 990
      n2_delta = 11

    while n2 > n1:
      loop_count += 1
      product = n1 * n2
      n2 -= n2_delta
      if product <= largest_pdrome:
        break
      if is_palindrome(product) and product > largest_pdrome:
        largest_pdrome = product

  print(f'{loop_count} Loops looped for p4cool')
  return largest_pdrome


p4()
p4_cool()
print(p4_coolest())
# solution = p4()
# print(solution)
