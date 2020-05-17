def s = ["6-3",
"4-3,5-1,2-2,1-3,4-4",
"1-1,3-5,5-2,2-3,2-4",
"1-1,3-5,5-2,2-3,2-4,1-1,3-5,5-2,2-3,3-5,5-3",
"3-2,2-1,1-4,4-4,5-4,4-2,2-1",// => 4
"5-5,5-5,4-4,5-5,5-5,5-5,5-5,5-5,5-5,5-5"// => 7
]

s.each { String str ->
  int max = 1;
  String[] tiles = str.split(",");
  for (int i = 0; i < tiles.length - 1; i++) {

    int localMax = 1;
    int start = i;
    while (i < tiles.length - 1) {
      String[] t1 = tiles[i].split('-');
      String[] t2 = tiles[i + 1].split('-');
      if (t1[1] == t2[0]) {
        localMax++;
        i++;
      } else {
        break;
      }
    }
    i = start;
    if (localMax > max) {
      max = localMax;
    }
  }
  println(str + " has max:" + max);
}
