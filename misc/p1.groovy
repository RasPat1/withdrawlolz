/*
We are given an NxN square matrix, whose elements represent a position on a minesweeper game board. An element can either be "O", meaning that it's empty, or "X", meaning that there is a mine at that position. Devise a function that, given the input matrix, returns a matrix in which every empty cell is replaced by the number of mines in the Moore neighborhood of that cell. The Moore neighborhood comprises the eight cells surrounding the cell, four directly next to it and four diagonal to it.

The input is a string, with each line representing a row in the matrix.

For example:
INPUT:
X O O X X X O O
O O O O X O X X
X X O X X O O O
O X O O O X X X
O O X X X X O X
X O X X X O X O
O O O X O X O X
X O X X O X O X

OUTPUT:
X 1 1 X X X 3 2
3 3 3 5 X 5 X X
X X 3 X X 5 5 4
3 X 5 5 6 X X X
2 4 X X X X 6 X
X 3 X X X 5 X 3
2 4 5 X 6 X 5 X
X 2 X X 4 X 4 X
*/

def solve(def arr) {
  for (int i = 0; i < arr.size(); i++) {
    for (int j = 0; j < arr[i].size(); j++) {
      if (arr[i][j] != 'X') {
        def count = getMooreCount(i,j,arr);;

        if (count > 0) {
          arr[i][j] = count;
        }
      }
    }
  }
  return arr;
}
def getMooreCount(i,j,arr) {
  def count = 0;
  // above row
  if (i-1 > 0) {
    def row = arr[i-1];
    if (row[j-1] == 'X') {
      count++
    }
    if (row[j] == 'X') {
      count++
    }
    if (row[j+1] == 'X') {
      count++
    }
  }

  // current row
  if (arr[i] != null) {
    def row = arr[i];
    if (row[j-1] == 'X') {
      count++
    }
    if (row[j+1] == 'X') {
      count++
    }
  }

  // row below
  if (i+1 < arr.size()) {
    def row = arr[i+1];
    if (row[j-1] == 'X') {
      count++
    }
    if (row[j] == 'X') {
      count++
    }
    if (row[j+1] == 'X') {
      count++
    }
  }

  return count
}

def input = [
  ['O', 'O', 'O', 'X', 'X', 'X', 'O'],
  ['X', 'O', 'O', 'X', 'X', 'X', 'O']

]

print(solve(input));


