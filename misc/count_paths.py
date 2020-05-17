def count_paths(n, m):
  if n == 0 and m == 0:
    return None
  def _all_paths(i, j, max_i, max_j):

    if i == max_i or j == max_j:
      return 1
    else:
      return _all_paths(i+1, j, max_i, max_j) + _all_paths(i, j+1, max_i, max_j)

  return _all_paths(0, 0, n-1, m-1)

n = 3
m = 3
print count_paths(n, m)