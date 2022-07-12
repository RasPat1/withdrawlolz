# Problem Statement
# You have 100 prisoners in a squid game.
# The numbers 1-100 are uniquely assigned to each prisoner.
# Each prisoner will, one at a time, enter a room filled with 100 boxes.
# The boxes are similarly numbered 1-100, but the numbering is not
# visible on the outside of the box.
# A prisoner can open a box, see the number inside the box, and enter the
# box if and only if their number matches the boxes number.
# Each prisoner can open up to 50 boxes.
# If any prisoner can’t find their box within 50 tries the game ends in a loss.
# Otherwise, the game ends in a win if all prisoners have entered the correct box.

# Additional notes:

# - Prisoners can strategize freely before the game begins.
# - Prisoners can arrange the boxes before the game begins.
# - Prisoners can choose their numbers.
# - Prisoners can choose in what order they enter the box room.
# - Once a prisoner enters a box they are visible by all who open the same box.
# - The optimal strategy allows for all prisoners to survive ~30% of the time.


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
