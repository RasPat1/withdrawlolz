dir = [(1,0), (0,1), (-1,0), (0,-1)];

def gen_tetris(n, pieces = {})
  If n == 1
    # This a fake pseudocode Set of Sets of Tuples
    return { { (0,0) } };
  end

  newPieces = {}

  pieces.each do |piece|
    piece.each do |block|
      var newPiece = piece.copy
      dirs.each do |dir|
        newBlock = block + dir

        if !piece.contains newBlock
          newPiece.add newBlock
          newPieces.add newPiece
        end

      end
    end
  end

  newPieces = deDupe(newPieces)

  return gen_tetris(n-1, newPieces);
end

def deDupe(pieces)
  validPieces = {}

  pieces.each do |piece|
    minX, minY = findMins(piece)

    shiftedPiece = {}
    piece.each do |block|
      # # This isn't quite right. We want to shift so we have something at 0,0
      # What if there is a piece at (-1,0), (0, 0) and (-1, -1)
      shiftedPiece << block + (minX, minY)
    end

    # rotatePiece in all rotations
    # Add the 4th rotation (the original shifted piece) if we couldn't find an existing copy
    hasAVersion = false
    4.times do
      shiftedPiece = rotate(shiftedPiece)
      if validPieces.contains(shiftedPiece) && !hasAVersion
        hasAVersion = true
      end
    end

    if !hasAVersion
      validPieces.add(shiftedPiece)
    end
  end

  return validPieces;
end

def findMin(piece)
  minX = piece.size
  minY = piece.size

  piece.each do |block|
    minX = min(minX, block[0])
    minY = min(minY, block[1])
  end

  return [minX, minY]
end

# Rotation is defined by (x,y) => (-y, x)
def rotate(piece)
  rotatedPiece = {}

  piece.each do |block|
    newBlock = (newBlock[1], -1 * newBlock[0])
    rotatedPiece.add(newBlock)
  end

  return rotatedPiece
end
