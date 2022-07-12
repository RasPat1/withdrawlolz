# Problem Statement
# You have 100 players in a squid game.
# The numbers 1-100 are uniquely assigned to each player.
# Each player will, one at a time, enter a room filled with 100 boxes.
# Each box contains a unqiue number from 1-100.
# A player can only see a box's number by opening that box.
# Each player is allowed to open up to 50 boxes while in the room.
# Once they find the box containing their number or open 50 boxes they leave the room.
# The game is won if all players find their box before leaving the room.
# What strategy maximizes their chance of winning the game?

# Additional notes:

# - Players can strategize freely before the game begins.
# - Players can arrange the boxes before the game begins.
# - Players can choose in what order they enter the box room.
# - The optimal strategy allows for all players to survive ~30% of the time.


import random


def solve(shuffled_boxes, max_box_checks):
  for target_num in range(0, len(shuffled_boxes)):
    checks_used = 0
    box_index = target_num
    while True:
      box_value = shuffled_boxes[box_index]
      box_index = box_value
      checks_used += 1
      # We found the correct box! Keep playing.
      if box_value == target_num:
        break
      # We ran out of checks. Game over.
      if checks_used >= max_box_checks:
        return False
  # We found the target box for every number.
  return True


def test(box_coune, max_box_checks, runs):
  boxes = list(range(box_count))
  success_count = 0

  for _ in range(runs):
    random.shuffle(boxes)
    solved = solve(boxes, max_box_checks)

    if solved:
      success_count += 1

  print(f'Successful Percent: {success_count * 100 / runs}%')
  print(f'Successful Runs:    {success_count}')


box_count = 100
max_box_checks = 50
runs = 10000
test(box_count, max_box_checks, runs)
